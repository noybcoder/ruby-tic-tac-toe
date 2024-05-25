module CustomErrors
  class InvalidAvatarChoice < StandardError
    def initialize(msg='Please only choose from "O" and "X".', exception_type='custom')
      @exception_type = exception_type
      super(msg)
    end
  end

  class PlayerLimitViolation < StandardError
    def initialize(msg='Tic-tac-toe only allows up to 2 players.', exception_type='custom')
      @exception_type = exception_type
      super(msg)
    end
  end

  class BoardLimitViolation < StandardError
    def initialize(msg='Each Tic-tac-toe game only allows 1 board.', exception_type='custom')
      @exception_type = exception_type
      super(msg)
    end
  end

  class InvalidBoardPosition < StandardError
    def initialize(msg='The position has either been taken or is not valid.', exception_type='custom')
      @exception_type = exception_type
      super(msg)
    end
  end
end
