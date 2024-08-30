package funkin.objects.notes;

// based off funkin kinda
enum abstract Direction(Int) from Int to Int {
    var LEFT = 0;
    var DOWN = 1;
    var UP = 2;
    var RIGHT = 3;
    public function toString():String {
        return switch (this) {
            case LEFT: 'left';
            case DOWN: 'down';
            case UP: 'up';
            case RIGHT: 'right';
            default: 'unknown';
        }
    }
    public function getColor():String {
        return switch (this) {
            case LEFT: 'purple';
            case DOWN: 'blue';
            case UP: 'green';
            case RIGHT: 'red';
            default: 'unknown';
        }
    }
}