import { createPoll } from "ags/time";

export default function Clock() {
  const time = createPoll("", 1000, "date +'%H:%M'");

  return (
    <button class="clock">
      <label label={time} />
    </button>
  );
}
