import { Variable } from "astal"
import { formatTime } from "../../../lib/utils"
import { config } from "../../../config"

export function Clock() {
    const time = Variable(formatTime(config.clock.format))
    
    setInterval(() => {
        time.set(formatTime(config.clock.format))
    }, config.clock.interval)
    
    return (
        <box className="clock">
            <label label={time()} />
        </box>
    )
}
