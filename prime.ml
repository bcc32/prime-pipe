open Core.Std
open Async.Std

let nats ~init =
  let r, w = Pipe.create () in
  let rec loop n =
    Pipe.write_if_open w n
    >>> fun () -> loop (n + 1)
  in
  loop init;
  r
;;

let primes () =
  let r, w = Pipe.create () in
  let rec loop stream =
    Pipe.read stream
    >>> function
    | `Eof -> failwith "got Eof"
    | `Ok n ->
      Pipe.write_if_open w n
      >>> fun () ->
      let filtered = Pipe.filter stream ~f:(fun m -> m mod n <> 0) in
      loop filtered
  in
  loop (nats ~init:2);
  r
;;
