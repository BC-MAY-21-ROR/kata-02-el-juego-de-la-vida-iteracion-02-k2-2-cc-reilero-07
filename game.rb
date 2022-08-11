# Clase de celulas
class Cell

  attr_accessor :status

  def initialize(status)
    @status = status
  end

end

# Clase de tablero
class Board
  attr_reader :board

  def initialize(rows, cols)
    @board = Array.new(rows) { Array.new(cols) }
  end

  def cols
    @board[0].length
  end

  def rows
    @board.length
  end

  def fill_cell (pos_x, pos_y, element)
    @board[pos_x][pos_y] = element
  end

  def get_cell (pos_x, pos_y)
    @board[pos_x][pos_y]
  end

  def print 
    @board.each do |row|
      puts row.join(' ')
    end
  end

end

class GameOfLife

  def initialize()

  end

  def next()

  end
end