function solvedSudoku = solveSudoku1(sudoku)

    [solvedSudoku, isSolved] = solve(sudoku);
    if isSolved
        disp('Sudoku solved successfully.');
    else
        disp('Could not solve the Sudoku.');
        solvedSudoku = zeros(9);
    end
end

function [sudoku, isSolved] = solve(sudoku)
    [row, col] = find(sudoku == 0, 1); % Find the first empty cell
    if isempty(row) && isempty(col) % No empty cells left, Sudoku is solved
        isSolved = true;
        return;
    end

    for num = 1:9
        if isNumValid(sudoku, row, col, num)
            sudoku(row, col) = num; % Try placing a number

            [sudoku, isSolved] = solve(sudoku); % Recursively solve

            if isSolved % If the solution is found, return
                return;
            end

            sudoku(row, col) = 0; % Backtrack if the number doesn't lead to a solution
        end
    end

    isSolved = false; % No solution found
end

function isValid = isNumValid(sudoku, row, col, num)
 
    % Check row
    if any(sudoku(row, :) == num)
        isValid = false;
        return;
    end

    % Check column
    if any(sudoku(:, col) == num)
        isValid = false;
        return;
    end

    % Check subgrid
    subgridRow = 3 * floor((row - 1) / 3) + 1;
    subgridCol = 3 * floor((col - 1) / 3) + 1;
    if any(reshape(sudoku(subgridRow:subgridRow + 2,...
            subgridCol:subgridCol + 2), 1, []) == num)
        isValid = false;
        return;
    end

    isValid = true;
end