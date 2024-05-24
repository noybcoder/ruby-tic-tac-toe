module CustomErrors
  class InvalidAvatarChoice < StandardError
    def initialize(msg='Please only choose from "O" and "X".', exception_type='custom')
      @exception_type = exception_type
      super(msg)
    end
  end

  class GameRulesViolation < StandardError
    def initialize(msg='Tic-tac-toe only allows up to 2 players.', exception_type='custom')
      @exception_type = exception_type
      super(msg)
    end
  end
end
