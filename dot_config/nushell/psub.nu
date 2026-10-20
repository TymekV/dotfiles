export def main [
task: closure # The task to run
--write(-w) # Have the task read from the produced pipe instead of write to it so that a caller can write to it
--timeout(-t): duration # Abort the spawned task after a given amount of time
]: [
any -> path
] {
let input = $in
let pipe = mktemp -d | path join (random uuid)
mkfifo $pipe

let id = job spawn { # |id| # TODO: Pass ID to closure when #15220 gets resolved
if $write {
open -r $pipe | do $task # $id
} else {
try {
$in | do $task # $id
| save --append $pipe
} catch {|err|
print -e $err.rendered # TODO: Check for EPIPE
}
}
rm -rf ($pipe | path dirname)
}
if $timeout != null {
job spawn {
sleep $timeout
if $id in (job list | get id) {
job kill $id
print -e $"psub task id ($id) timed out"
}
rm -rf ($pipe | path dirname)
}
}

$pipe
}
