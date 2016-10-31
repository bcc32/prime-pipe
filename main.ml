open Core.Std
open Async.Std

let command =
  Command.async' ~summary:"print out prime numbers" begin
    Command.Param.return begin
      fun () ->
        let primes = Prime.primes () in
        let stdout = force Writer.stdout in
        Pipe.iter_without_pushback primes ~f:(Writer.writef stdout "%d\n")
    end
  end
;;

let () = Command.run command
