open Core.Std
open Async.Std

let nats ~init = Sequence.unfold ~init ~f:(fun s -> Some (s, s + 1)) |> Pipe.of_sequence

let primes () =
  let r, w = Pipe.create () in
  let stream = ref (nats ~init:2) in
  let rec loop () =
    Pipe.read !stream
    >>> function
    | `Eof -> failwith "got Eof"
    | `Ok n ->
      Pipe.write_if_open w n
      >>> fun () ->
      stream := Pipe.filter !stream ~f:(fun m -> m mod n <> 0);
      loop ()
  in
  loop ();
  r
;;
