require_relative 'PolyTreeNode'
class KnightPathFinder
  def initialize(position_array)
    @considered_positions = [position]
    @root_node = PolyTreeNode.new(position_array)
    build_move_tree
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      node = queue.shift
      process(node)
      positions = new_move_positions(node.value)
      node.children.each { |child_node| queue << child_node }
    end
  end

  def process(node)
    positions = new_move_positions(node.value)
    positions.each { |pos| PolyTreeNode.new(pos).parent = node }
  end

  def self.valid_moves(pos)
    row, col = pos
    moves_array = []
    if row == 0 and col == 0
      moves_array << [row, col + 1]
      moves_array << [row + 1, col]
      moves_array << [row + 1, col + 1]
    elsif row == 7 and col == 0
      moves_array << [row - 1, col]
      moves_array << [row - 1, col + 1]
      moves_array << [row, col + 1]
    elsif row == 0 and col == 7
      moves_array << [row, col - 1]
      moves_array << [row + 1, col - 1]
      moves_array << [row + 1, col]
    elsif row == 7 and col == 7
      moves_array << [row - 1, col - 1]
      moves_array << [row - 1, col]
      moves_array << [row, col - 1]
    elsif row == 0
      moves_array << [row, col - 1]
      moves_array << [row, col + 1]
      moves_array << [row + 1, col - 1]
      moves_array << [row + 1, col]
      moves_array << [row + 1, col + 1]
    elsif row == 7
      moves_array << [row - 1, col - 1]
      moves_array << [row - 1, col]
      moves_array << [row - 1, col + 1]
      moves_array << [row, col - 1]
      moves_array << [row, col + 1]
    elsif col == 0
      moves_array << [row - 1, col]
      moves_array << [row - 1, col + 1]
      moves_array << [row, col + 1]
      moves_array << [row + 1, col]
      moves_array << [row + 1, col + 1]
    elsif col == 7
      moves_array << [row - 1, col - 1]
      moves_array << [row - 1, col]
      moves_array << [row, col - 1]
      moves_array << [row + 1, col - 1]
      moves_array << [row + 1, col]
    else
      moves_array << [row - 1, col - 1]
      moves_array << [row - 1, col]
      moves_array << [row - 1, col + 1]
      moves_array << [row, col - 1]
      moves_array << [row, col + 1]
      moves_array << [row + 1, col - 1]
      moves_array << [row + 1, col]
      moves_array << [row + 1, col + 1]
    end
    moves_array
  end

  def new_move_positions(pos)
    return nil if pos.nil?

    correct_moves_array = []
    moves_array = valid_moves(pos)
    moves_array.each do |position|
      unless @considered_positions.include?(position)
        correct_moves_array << position
        @considered_positions << position
      end
    end
    correct_moves_array
  end
end
