class Game
  #we are reading the values
  attr_reader :error_message, :frame_number, :frame

  # defined constant based on the requirement
  FRAMES = 10
  PINS   = 10

  def initialize(params, frame)
    @frame = frame.nil? ? [nil] : frame
    @ball1 = params[:ball1].to_i if params[:ball1]
    @ball2 = params[:ball2].to_i if params[:ball2]
    @ball3 = params[:ball3].to_i if params[:ball3]
    frame_number
  end
#It returns the frame size based on the conditions which wrote in valid method down in the file
  def frame_number
    @frame_number ||= valid? ? frame.size : frame.size - 1
  end

  #it calculates the score
  def calc
    @frame[frame_number] = {spare: spare?, strike: strike?, score: calc_frame_score}
  end

  # it returns the total score for all the frames
  def total
    @frame.inject(0){|rez, item| item ? rez + item[:score] : rez }
  end

  #after the complation of 10 frames,game is over(we are not having chance to enter one more frame)
  def over?
    frame_number >= FRAMES + (frame_number == FRAMES && (strike? || spare?)  ? 1 : 0)
  end

  #if first trail is 10 the second trail wont be there
  def strike?
    @ball1 == PINS
  end

  #it counts the first and second trail pins and it should be equal to 10 or less than 10
  def spare?
    @ball1 + @ball2 == PINS
  end

  #checks for the valid frame and pins
  def valid?
    @valid ||= begin
      @error_message = ''
      if !@ball1 || !in_range(@ball1)
        @error_message = 'The 1st ball knocked wrong number of pins'
        return
      end
      if (!strike? && !@ball2) || !in_range(@ball2)
        @error_message = 'The 2nd ball knocked wrong number of pins'
        return
      end
      if !strike? && !in_range(@ball1 + @ball2)
        @error_message = 'The sum of knocked pins is wrong'
        return
      end
      true
    end
  end

  private
  #it calculates each frame score
  def calc_frame_score
    prev_frame = frame[frame_number - 1]
    if prev_frame && (prev_frame[:strike] || prev_frame[:spare])
      frame[frame_number - 1][:score] = PINS + @ball1 + (prev_frame[:strike] ? @ball2 : 0)
    end
    @ball1 + @ball2
  end

  #pins should be range of 0 to 10
  def in_range(num)
    (0..PINS) === num
  end

end