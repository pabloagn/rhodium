import { exec, execAsync } from "astal"
import GLib from "gi://GLib"

export function range(start: number, end?: number): number[] {
    if (end === undefined) {
        end = start
        start = 0
    }
    return Array.from({ length: end - start }, (_, i) => start + i)
}

export function formatTime(format: string = "%H:%M:%S"): string {
    return GLib.DateTime.new_now_local().format(format)!
}

export async function sh(cmd: string): Promise<string> {
    return execAsync(["bash", "-c", cmd])
}
