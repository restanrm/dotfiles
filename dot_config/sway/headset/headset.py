import evdev
import pulsectl
import loguru


def set_source_port():
    pulse = pulsectl.Pulse("Enable headset Mic Client")
    source = None
    for src in pulse.source_list():
        loguru.logger.debug(f"{src=}")
        if src.description == "Audio interne Stéréo analogique":
            source = src
    if source is None:
        loguru.logger.error("Failed to retrieve source used by Microphone")
        return

    port = None
    for p in source.port_list:
        loguru.logger.debug(f"port={p}")
        if "headset" in p.description.lower():
            port = p
    if port is None:
        loguru.logger.error("Failed to retrieve ports used by source")
        return

    pulse.port_set(source, port)


def main():
    device = None
    for dev in [evdev.InputDevice(path) for path in evdev.list_devices()]:
        if "Mic" in dev.name:
            device = dev

    event = None
    for ev in device.read_loop():
        if (
            ev.type == evdev.ecodes.EV_SW
            and ev.code == evdev.ecodes.SW_HEADPHONE_INSERT
            and ev.value == 1
        ):
            set_source_port()
            loguru.logger.info("Switching microphone to headset")


if __name__ == "__main__":
    main()
