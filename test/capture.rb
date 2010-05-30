class IO

  # Runs a command and yields an IO object opened for reading from the command.
  # Does *NOT* do any shell expansion (that's the point).
  # +args+ should be program,arg1,...
  # You may also pass an optional hash of parameters as the last argument to
  # control the behavior:
  #   :stderr - set to +true+ to include stderr output in the captured stream
  def self.capture(*args)
    # avoid shell expansion using fork/exec
    opts = (Hash === args.last) ? args.pop : {}
    want_stderr = opts[:stderr]
    
    reader, writer = IO.pipe
    retval = nil
    if pid = fork
      writer.close
      if block_given?
        retval = yield(reader)
      else
        retval = reader.read
      end
      Process.waitpid(pid)
    else
      begin
        reader.close
        STDIN.reopen("/dev/null")
        STDOUT.reopen(writer)
        STDERR.reopen(writer) if want_stderr
        exec(*(args.flatten))
      rescue => e
        # prevent child from jumping out of this scope and continuing main program
        STDERR.puts(e.to_s)
      end 
      exit! # will only reach here if exec() failed
    end
    retval
  end 

end
