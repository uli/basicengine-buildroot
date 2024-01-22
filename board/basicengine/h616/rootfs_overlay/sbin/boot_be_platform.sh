# H616 platform configuration

# Jailhouse configuration
JH_PLATFORM=orangepizero2

# analog codec mixer setup
amixer_command="amixer -c 1"
$amixer_command set 'Left LINEOUT Mux' 'LOMixer'
$amixer_command set 'Left Output Mixer DACL' on
$amixer_command set 'Left Output Mixer DACR' on
$amixer_command set 'Right LINEOUT Mux' 'ROMixer'
$amixer_command set 'Right Output Mixer DACL' on
$amixer_command set 'Right Output Mixer DACR' on

# turn on audio devices and leave them running
aplay -D default:CARD=audiocodec -t raw /dev/zero -c 2 -r 48000 -f S16_LE -N &
aplay -D default:CARD=HDMI -t raw /dev/zero -c 2 -r 48000 -f S16_LE -N &
