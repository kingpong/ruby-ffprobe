require 'fcntl'

class FFProbe
  class SafePipe
    
    attr_accessor :program, :args, :status
    
    def initialize(program,*args)
      self.program = program
      self.args = args
    end
    
    def run(&optional_block)
      # closing of this pipe will indicate successful exec,
      # otherwise it will stream the error
      @rexec, @wexec = IO.pipe.map {|io| set_close_on_exec(io); io }
      @reader, @writer = IO.pipe
      if @pid = fork
        parent(&optional_block)
      else
        child
      end
    end
    
    def success?
      status ? status.success? : nil
    end
    
    private
    
    def parent
      @writer.close
      @wexec.close
      wait_for_exec
      if block_given?
        yield(@reader)
      else
        @reader.read
      end
    ensure
      # exception might have been caused by yielded code.
      # send child sigpipe so it might not linger while we ignore it.
      @reader.close rescue nil
      # prevent zombie
      reaped, status = Process.waitpid2(@pid)
      self.status = status
    end
    
    def child
      @reader.close
      @rexec.close
      $stdin.reopen("/dev/null")
      $stdout.reopen(@writer)
      $stderr.reopen(@writer)
      exec(self.program, *self.args)
    rescue => e
      @wexec.write Marshal.dump(e)
    ensure
      exit!
    end
    
    def wait_for_exec
      exec_result = @rexec.read
      # if exec failed, this will be a marshalled exception
      raise Marshal.load(exec_result) unless exec_result.empty?
    end
    
    def set_close_on_exec(io)
      flags = io.fcntl(Fcntl::F_GETFD)
      flags |= Fcntl::FD_CLOEXEC
      io.fcntl(Fcntl::F_SETFD, flags)
    end
    
  end
end
