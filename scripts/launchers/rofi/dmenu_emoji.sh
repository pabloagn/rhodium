#!/usr/bin/env bash

# Define a list of emojis
EMOJI_LIST=$(cat <<EOF
😀 Grinning Face
😁 Beaming Face with Smiling Eyes
😂 Face with Tears of Joy
😃 Grinning Face with Big Eyes
😄 Grinning Face with Smiling Eyes
😅 Grinning Face with Sweat
😆 Grinning Squinting Face
😉 Winking Face
😊 Smiling Face with Smiling Eyes
😋 Face Savoring Food
😎 Smiling Face with Sunglasses
😍 Smiling Face with Heart-Eyes
😘 Face Blowing a Kiss
😗 Kissing Face
😙 Kissing Face with Smiling Eyes
😚 Kissing Face with Closed Eyes
🙂 Slightly Smiling Face
🤗 Hugging Face
🤔 Thinking Face
😐 Neutral Face
😑 Expressionless Face
😶 Face Without Mouth
🙄 Face with Rolling Eyes
😏 Smirking Face
😣 Persevering Face
😥 Sad but Relieved Face
😮 Face with Open Mouth
🤐 Zipper-Mouth Face
😯 Hushed Face
😪 Sleepy Face
😫 Tired Face
😴 Sleeping Face
😌 Relieved Face
😛 Face with Tongue
😜 Winking Face with Tongue
😝 Squinting Face with Tongue
🤤 Drooling Face
😒 Unamused Face
😓 Downcast Face with Sweat
😔 Pensive Face
😕 Confused Face
🙃 Upside-Down Face
🤑 Money-Mouth Face
😲 Astonished Face
☹️ Frowning Face
🙁 Slightly Frowning Face
😖 Confounded Face
😞 Disappointed Face
😟 Worried Face
😤 Face with Steam from Nose
😢 Crying Face
😭 Loudly Crying Face
😦 Frowning Face with Open Mouth
😧 Anguished Face
😨 Fearful Face
😩 Weary Face
😰 Anxious Face with Sweat
😱 Face Screaming in Fear
😳 Flushed Face
🤪 Zany Face
😵 Dizzy Face
😡 Pouting Face
😠 Angry Face
🤬 Face with Symbols on Mouth
😷 Face with Medical Mask
🤒 Face with Thermometer
🤕 Face with Head-Bandage
🤢 Nauseated Face
🤮 Face Vomiting
🤧 Sneezing Face
🥵 Hot Face
🥶 Cold Face
🥴 Woozy Face
😵‍💫 Face with Spiral Eyes
😇 Smiling Face with Halo
🥳 Partying Face
🥸 Disguised Face
😈 Smiling Face with Horns
👿 Angry Face with Horns
👹 Ogre
👺 Goblin
💀 Skull
☠️ Skull and Crossbones
👻 Ghost
👽 Alien
👾 Alien Monster
🤖 Robot
😺 Grinning Cat
😸 Grinning Cat with Smiling Eyes
😹 Cat with Tears of Joy
😻 Smiling Cat with Heart-Eyes
😼 Cat with Wry Smile
😽 Kissing Cat
🙀 Weary Cat
😿 Crying Cat
😾 Pouting Cat
🙈 See-No-Evil Monkey
🙉 Hear-No-Evil Monkey
🙊 Speak-No-Evil Monkey
💋 Kiss Mark
💌 Love Letter
💘 Heart with Arrow
💝 Heart with Ribbon
💖 Sparkling Heart
💗 Growing Heart
💓 Beating Heart
💞 Revolving Hearts
💕 Two Hearts
💟 Heart Decoration
❣️ Heart Exclamation
💔 Broken Heart
❤️ Red Heart
🧡 Orange Heart
💛 Yellow Heart
💚 Green Heart
💙 Blue Heart
💜 Purple Heart
🤎 Brown Heart
🖤 Black Heart
🤍 White Heart
💯 Hundred Points
💢 Anger Symbol
💥 Collision
💫 Dizzy
💦 Sweat Droplets
💨 Dashing Away
🕳️ Hole
💣 Bomb
💬 Speech Balloon
👁️‍🗨️ Eye in Speech Bubble
🗨️ Left Speech Bubble
🗯️ Right Anger Bubble
💭 Thought Balloon
💤 Zzz
👋 Waving Hand
🤚 Raised Back of Hand
🖐️ Hand with Fingers Splayed
✋ Raised Hand
🖖 Vulcan Salute
👌 OK Hand
🤌 Pinched Fingers
🤏 Pinching Hand
✌️ Victory Hand
🤞 Crossed Fingers
🤟 Love-You Gesture
🤘 Sign of the Horns
🤙 Call Me Hand
👈 Backhand Index Pointing Left
👉 Backhand Index Pointing Right
👆 Backhand Index Pointing Up
🖕 Middle Finger
👇 Backhand Index Pointing Down
☝️ Index Pointing Up
👍 Thumbs Up
👎 Thumbs Down
✊ Raised Fist
👊 Oncoming Fist
🤛 Left-Facing Fist
🤜 Right-Facing Fist
👏 Clapping Hands
🙌 Raising Hands
👐 Open Hands
🤲 Palms Up Together
🤝 Handshake
🙏 Folded Hands
✍️ Writing Hand
💅 Nail Polish
🤳 Selfie
💪 Flexed Biceps
🦾 Mechanical Arm
🦿 Mechanical Leg
🦵 Leg
🦶 Foot
👂 Ear
🦻 Ear with Hearing Aid
👃 Nose
🧠 Brain
🫀 Anatomical Heart
🫁 Lungs
🦷 Tooth
🦴 Bone
👀 Eyes
👁️ Eye
👅 Tongue
👄 Mouth
🫦 Biting Lip
👶 Baby
🧒 Child
👦 Boy
👧 Girl
🧑 Person
👱 Person: Blond Hair
👨 Man
🧔 Person: Beard
👨‍🦰 Man: Red Hair
👨‍🦱 Man: Curly Hair
👨‍🦳 Man: White Hair
👨‍🦲 Man: Bald
👩 Woman
👩‍🦰 Woman: Red Hair
👩‍🦱 Woman: Curly Hair
👩‍🦳 Woman: White Hair
👩‍🦲 Woman: Bald
🧓 Older Person
👴 Old Man
👵 Old Woman
🙍 Person Frowning
🙎 Person Pouting
🙅 Person Gesturing No
🙆 Person Gesturing OK
💁 Person Tipping Hand
🙋 Person Raising Hand
🧏 Deaf Person
🙇 Person Bowing
🤦 Person Facepalming
🤷 Person Shrugging
👨‍⚕️ Man Health Worker
👩‍⚕️ Woman Health Worker
👨‍🎓 Man Student
👩‍🎓 Woman Student
👨‍🏫 Man Teacher
👩‍🏫 Woman Teacher
👨‍⚖️ Man Judge
👩‍⚖️ Woman Judge
👨‍🌾 Man Farmer
👩‍🌾 Woman Farmer
👨‍🍳 Man Cook
👩‍🍳 Woman Cook
👨‍🔧 Man Mechanic
👩‍🔧 Woman Mechanic
👨‍🏭 Man Factory Worker
👩‍🏭 Woman Factory Worker
👨‍💼 Man Office Worker
👩‍💼 Woman Office Worker
👨‍🔬 Man Scientist
👩‍🔬 Woman Scientist
👨‍💻 Man Technologist
👩‍💻 Woman Technologist
👨‍🎤 Man Singer
👩‍🎤 Woman Singer
👨‍🎨 Man Artist
👩‍🎨 Woman Artist
👨‍✈️ Man Pilot
👩‍✈️ Woman Pilot
👨‍🚀 Man Astronaut
👩‍🚀 Woman Astronaut
👨‍🚒 Man Firefighter
👩‍🚒 Woman Firefighter
👮 Police Officer
👮‍♂️ Man Police Officer
👮‍♀️ Woman Police Officer
🕵️ Detective
🕵️‍♂️ Man Detective
🕵️‍♀️ Woman Detective
💂 Guard
💂‍♂️ Man Guard
💂‍♀️ Woman Guard
🥷 Ninja
👷 Construction Worker
👷‍♂️ Man Construction Worker
👷‍♀️ Woman Construction Worker
🤴 Prince
👸 Princess
👳 Person Wearing Turban
👳‍♂️ Man Wearing Turban
👳‍♀️ Woman Wearing Turban
👲 Person with Skullcap
🧕 Woman with Headscarf

EOF
)

# Show Rofi dmenu with emoji list
chosen=$(echo "$EMOJI_LIST" | rofi -dmenu -theme "/home/pabloagn/.dotfiles/user/desktop/rofi/themes/style-4.rasi" -i -p "Select Emoji:" | awk '{print $1}')

# Copy selected emoji to clipboard using wl-copy
if [ -n "$chosen" ]; then
    echo -n "$chosen" | wl-copy
    notify-send "Emoji copied to clipboard: $chosen"
else
    notify-send "No emoji selected"
fi
