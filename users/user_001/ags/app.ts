import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widgets/bar/Bar"

App.start({
    css: style,
    main() {
        Bar()
    },
})
