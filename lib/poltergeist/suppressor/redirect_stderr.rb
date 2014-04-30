module Capybara::Poltergeist
  class Client
    private
    def redirect_stderr
      prev = STDERR.dup
      prev.autoclose = false
      $stderr = @write_io
      STDERR.reopen(@write_io)

      yield
    ensure
      STDERR.reopen(prev)
      $stderr = STDERR
    end

    def redirect_stdout_with_stderr(&block)
      redirect_stderr do
        redirect_stdout_without_stderr(&block)
      end
    end

    alias_method :redirect_stdout_without_stderr, :redirect_stdout
    alias_method :redirect_stdout, :redirect_stdout_with_stderr
  end
end