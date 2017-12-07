require_relative 'spec_helper'
require_relative '../robot'

RSpec.describe Robot do
  let(:robot) { described_class.new }

  describe '#place' do
    context 'with invalid params' do
      it 'raises exception with invalid x coordinate' do
        expect { robot.place(10, 0, 'WEST') }.to raise_error(Robot::Error)
      end

      it 'raises exception with invalid y coordinate' do
        expect { robot.place(0, 10, 'WEST') }.to raise_error(Robot::Error)
      end

      it 'raises exception with invalid direction' do
        expect { robot.place(1, 1, 'FOO') }.to raise_error(Robot::Error)
      end
    end

    context 'with valid params' do
      before { robot.place(2, 3, 'WEST') }

      it 'sets coordinates' do
        expect(robot.x).to eq(2)
        expect(robot.y).to eq(3)
      end

      it 'sets direction' do
        expect(robot.direction).to eq('WEST')
      end
    end

    context 'when run place multiple times' do
      it 'updates coordinates and direction' do
        robot.place(1, 2, 'SOUTH')

        expect(robot.x).to eq(1)
        expect(robot.y).to eq(2)
        expect(robot.direction).to eq('SOUTH')

        robot.place(4, 1, 'WEST')

        expect(robot.x).to eq(4)
        expect(robot.y).to eq(1)
        expect(robot.direction).to eq('WEST')
      end
    end
  end

  describe '#move' do
    context 'if not placed' do
      it 'returns nil' do
        expect(robot.move).to be_nil
      end
    end

    context 'with valid moves' do
      it 'moves robot to east' do
        robot.place(0, 0, 'EAST')
        expect { robot.move }.to change { robot.x }.from(0).to(1)
      end

      it 'moves robot to west' do
        robot.place(1, 0, 'WEST')
        expect { robot.move }.to change { robot.x }.from(1).to(0)
      end

      it 'moves robot to south' do
        robot.place(3, 4, 'SOUTH')
        expect { robot.move }.to change { robot.y }.from(4).to(3)
      end

      it 'moves robot to north' do
        robot.place(0, 1, 'NORTH')
        expect { robot.move }.to change { robot.y }.from(1).to(2)
      end
    end

    context 'with invalid moves' do
      it 'does not cross southern edge' do
        robot.place(0, 0, 'SOUTH')
        expect { robot.move }.not_to change { robot.y }
      end

      it 'does not cross north edge' do
        robot.place(0, 4, 'NORTH')
        expect { robot.move }.not_to change { robot.y }
      end

      it 'does not cross eastern edge' do
        robot.place(4, 4, 'EAST')
        expect { robot.move }.not_to change { robot.x }
      end

      it 'does not cross western edge' do
        robot.place(0, 2, 'WEST')
        expect { robot.move }.not_to change { robot.x }
      end
    end
  end

  describe '#left' do
    it 'turns from west to south' do
      robot.place(0, 0, 'WEST')
      expect { robot.left }.to change { robot.direction }.from('WEST').to('SOUTH')
    end

    it 'turns from south to east' do
      robot.place(0, 0, 'SOUTH')
      expect { robot.left }.to change { robot.direction }.from('SOUTH').to('EAST')
    end

    it 'turns from east to north' do
      robot.place(0, 0, 'EAST')
      expect { robot.left }.to change { robot.direction }.from('EAST').to('NORTH')
    end

    it 'turns from north to west' do
      robot.place(0, 0, 'NORTH')
      expect { robot.left }.to change { robot.direction }.from('NORTH').to('WEST')
    end

    context 'if not placed' do
      it 'returns nil' do
        expect(robot.left).to be_nil
      end
    end
  end

  describe '#right' do
    it 'turns from west to north' do
      robot.place(0, 0, 'WEST')
      expect { robot.right }.to change { robot.direction }.from('WEST').to('NORTH')
    end

    it 'turns from north to east' do
      robot.place(0, 0, 'NORTH')
      expect { robot.right }.to change { robot.direction }.from('NORTH').to('EAST')
    end

    it 'turns from east to south' do
      robot.place(0, 0, 'EAST')
      expect { robot.right }.to change { robot.direction }.from('EAST').to('SOUTH')
    end

    it 'turns from south to west' do
      robot.place(0, 0, 'SOUTH')
      expect { robot.right }.to change { robot.direction }.from('SOUTH').to('WEST')
    end

    context 'if not placed' do
      it 'returns nil' do
        expect(robot.right).to be_nil
      end
    end
  end

  describe '#report' do
    it 'prints current position and direction' do
      robot.place(1, 2, 'NORTH')
      expect(robot.report).to eq('1,2,NORTH')
    end

    context 'if not placed' do
      it 'returns nil' do
        expect(robot.report).to be_nil
      end
    end
  end
end
