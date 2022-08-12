# Clase de celulas
class Cell
  attr_accessor :status

  def initialize(status)
    @status = status
  end

  def to_s
    status ? '*' : '.'
  end


end

# Clase de tablero
class Board
  attr_reader :board

  def initialize(rows, cols, board = nil)
    if board
      @board = board
    else
      @board = Array.new(rows) { Array.new(cols) }
    end
  end

  def cols
    @board[0].length
  end

  def rows
    @board.length
  end

  def fill_cell(pos_x, pos_y, element)
    @board[pos_x][pos_y] = element
  end

  def get_cell(pos_x, pos_y)
    @board[pos_x][pos_y]
  end

  def show
    @board.each do |row|
      puts row.join(' ')
    end
  end

  def valid_position?(position)
    position[0] >= 0 && position[1] >= 0 && position[0] < rows && position[1] < cols
  end
end

# Comment
class GameOfLife
  def initialize
    @board
  end

  def board
    @board
  end

  def load_board(file_path)
    board_data = File.open(file_path).readlines.map(&:chomp).map do |row|
      row.split(//).map do |signo|
        signo == '.' ? Cell.new(false) : Cell.new(true)
      end
    end
    @board = Board.new(nil, nil, board_data)
  end

  def next
    new_board = Board.new(@board.rows,@board.cols)

    @board.board.each_index do |row_index|
      @board.board[row_index].each_index do |col_index|
        if @board.get_cell(row_index, col_index).status
          if alive_neighbour?(row_index, col_index) == 2 || alive_neighbour?(row_index, col_index) == 3
            new_board.fill_cell(row_index, col_index, Cell.new(true))
          else
            new_board.fill_cell(row_index, col_index, Cell.new(false))
          end
        else
          if alive_neighbour?(row_index, col_index) == 3
            new_board.fill_cell(row_index, col_index, Cell.new(true))
          else
            new_board.fill_cell(row_index, col_index, Cell.new(false))
          end
        end
      end
    end
    new_board
  end

  def alive_neighbour?(pos_x, pos_y)
    possible_neighbour_positions = [
      [pos_x - 1, pos_y - 1],
      [pos_x - 1, pos_y],
      [pos_x - 1, pos_y + 1],
      [pos_x, pos_y - 1],
      [pos_x, pos_y + 1],
      [pos_x + 1, pos_y - 1],
      [pos_x + 1, pos_y],
      [pos_x + 1, pos_y + 1]
    ]

    neighbour_positions = possible_neighbour_positions.select do |position|
      @board.valid_position?(position)
    end

    neighbours = neighbour_positions.map do |position|
      @board.get_cell(position[0], position[1])
    end

    alive_neighbours = neighbours.select do |neighbour|
      neighbour.status
    end

    alive_neighbours.length
  end
end