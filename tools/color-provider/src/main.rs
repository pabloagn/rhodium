// tools/color-provider/src/main.rs

use palette::{FromColor, Hsl, Srgb, Srgba, WithAlpha};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::env;
use std::fs;
use std::io::{self, Read};
use std::process;

#[derive(Deserialize, Debug, Clone)]
struct HslInput {
    h: f32, // Hue (0.0 - 360.0 degrees)
    s: f32, // Saturation (0.0 - 1.0)
    l: f32, // Lightness (0.0 - 1.0)
    a: Option<f32>, // Alpha (0.0 - 1.0, defaults to 1.0)
}

#[derive(Serialize, Debug)]
struct RgbOutput { r: u8, g: u8, b: u8 }

#[derive(Serialize, Debug)]
struct RgbaOutput { r: u8, g: u8, b: u8, a: u8 }

#[derive(Serialize, Debug)]
struct ProcessedColor {
    hsl: HslInput,      // Original HSL (alpha normalized to 1.0 if absent)
    hsla: HslInput,     // Original HSLA (explicit alpha)
    rgb: RgbOutput,     // r,g,b components (0-255)
    rgba: RgbaOutput,   // r,g,b,a components (0-255)
    hex: String,        // #RRGGBB
    #[serde(rename = "hexAlpha")]
    hex_alpha: String,  // #RRGGBBAA
    #[serde(rename = "rgbStr")]
    rgb_str: String,    // "rgb(r,g,b)"
    #[serde(rename = "rgbaStr")]
    rgba_str: String,   // "rgba(r,g,b,a)"
    #[serde(rename = "hyprlandHex")]
    hyprland_hex: String, // 0xAARRGGBB (alpha first)
}

type InputPalette = HashMap<String, HslInput>;
type OutputPalette = HashMap<String, ProcessedColor>;

fn main() -> io::Result<()> {
    let args: Vec<String> = env::args().collect();
    if args.len() != 2 {
        eprintln!("Usage: {} <input_json_file_path>", args[0]);
        process::exit(1);
    }

    let input_path = &args[1];
    let mut file_content = String::new();
    fs::File::open(input_path)?.read_to_string(&mut file_content)?;

    let input_palette: InputPalette = serde_json::from_str(&file_content)
        .unwrap_or_else(|e| {
            eprintln!("Error parsing input JSON: {}", e);
            process::exit(1);
        });

    let mut output_palette: OutputPalette = HashMap::new();

    for (name, hsl_val) in input_palette {
        let alpha_norm = hsl_val.a.unwrap_or(1.0);

        // Create HSL color object from the palette crate
        let hsl_color = Hsl::new_unchecked(hsl_val.h, hsl_val.s, hsl_val.l);
        let srgba_color = Srgba::from_color(hsl_color).with_alpha(alpha_norm);

        // Convert to sRGB bytes (0-255 range)
        let rgb_u8: [u8; 3] = Srgb::from_color(srgba_color.color).into_format().into();
        let r_u8 = rgb_u8[0];
        let g_u8 = rgb_u8[1];
        let b_u8 = rgb_u8[2];
        let a_u8 = (srgba_color.alpha * 255.0).round() as u8;

        let hex_val = format!("#{:02x}{:02x}{:02x}", r_u8, g_u8, b_u8);
        let hex_alpha_val = format!("#{:02x}{:02x}{:02x}{:02x}", r_u8, g_u8, b_u8, a_u8);

        output_palette.insert(
            name,
            ProcessedColor {
                hsl: HslInput { h: hsl_val.h, s: hsl_val.s, l: hsl_val.l, a: Some(1.0) },
                hsla: HslInput { h: hsl_val.h, s: hsl_val.s, l: hsl_val.l, a: Some(alpha_norm) },
                rgb: RgbOutput { r: r_u8, g: g_u8, b: b_u8 },
                rgba: RgbaOutput { r: r_u8, g: g_u8, b: b_u8, a: a_u8 },
                hex: hex_val,
                hex_alpha: hex_alpha_val,
                rgb_str: format!("rgb({},{},{})", r_u8, g_u8, b_u8),
                rgba_str: format!("rgba({},{},{},{:.2})", r_u8, g_u8, b_u8, alpha_norm),
                hyprland_hex: format!("0x{:02x}{:02x}{:02x}{:02x}", a_u8, r_u8, g_u8, b_u8),
            },
        );
    }

    let output_json = serde_json::to_string_pretty(&output_palette)?;
    println!("{}", output_json);

    Ok(())
}
