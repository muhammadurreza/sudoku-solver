function isValid = isValidSudoku(sudoku)
    % Check rows
    isValid = all(arrayfun(@(row) isvalidSet(sudoku(row, :)), 1:9));
    
    % Check columns
    isValid = isValid && all(arrayfun(@(col) isvalidSet(sudoku(:, col)), 1:9));
    
    % Check 3x3 subgrids
    for i = 1:3:9
        for j = 1:3:9
            isValid = isValid && isvalidSet(sudoku(i:i+2, j:j+2));
        end
    end
end

function isValid = isvalidSet(set)
    set = set(:);
    set = set(set ~= 0); % Ignore empty cells
    isValid = all(set >= 1 & set <= 9) && ...%chek number between 1 to 9
    length(set) == length(unique(set)) && ...%chek number is uniqe
    ~any(mod(set, 1) ~= 0);%chek number integer
end