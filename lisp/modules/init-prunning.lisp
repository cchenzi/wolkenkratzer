; Fix (max value) when (min value) is found
(defun min_value_coordinates (matrix i j n)
    (if (= i 0)
        (fix_value matrix i j n)
    )
    (if (= i 1)
        (fix_value matrix j (- n 1) n)
    )
    (if (= i 2)
        (fix_value matrix (- n 1) j n)
    )
    (if (= i 3)
        (fix_value matrix j 0 n)
    )
)

; Fix all values when (max value) is found
(defun max_value_coordinates (matrix i j n)
    
    (if (= i 0)
        (dotimes (q n)
            (fix_value matrix q j (+ 1 q))
        )
    )
    (if (= i 1)
        (dotimes (q n)
            (setq aux (- n 1 q))
            (fix_value matrix j aux (- n aux))
        )
    )
    (if (= i 2)
        (dotimes (q n)
            (setq aux (- n 1 q))
            (fix_value matrix aux j (- n aux))
        )
    )
    (if (= i 3)
        (dotimes (q n)
            (fix_value matrix j q (+ 1 q))
        )
    )
)

; exclude_possibilites based on view
(defun exclude_possibilites (matrix i j n vk_value)
    (if (= i 0)
        (dotimes (k (- vk_value 1)) 
            (setf proposed_length (+ (- n vk_value) k 1))
            (setf current_cell_value (aref matrix k j))
            (if (and (listp current_cell_value) 
                    (> (list-length current_cell_value) proposed_length) )
                (setf 
                    (aref matrix k j) 
                    (create_pruned_possibles proposed_length))
            )
        )        
    )
    (if (= i 1)
        (dotimes (k (- vk_value 1)) 
            (setf proposed_length (+ (- n vk_value) k 1))
            (setf current_cell_value (aref matrix j (- n k 1) ))
            (if (and (listp current_cell_value) 
                    (> (list-length current_cell_value) proposed_length) )
                (setf 
                    (aref matrix j (- n k 1)) 
                    (create_pruned_possibles proposed_length))
            )
        )        
    )
    (if (= i 2)
        (dotimes (k (- vk_value 1)) 
            (setf proposed_length (+ (- n vk_value) k 1))
            (setf current_cell_value (aref matrix (- n k 1) j))
            (if (and (listp current_cell_value) 
                    (> (list-length current_cell_value) proposed_length) )
                (setf 
                    (aref matrix (- n k 1) j) 
                    (create_pruned_possibles proposed_length))
            )
        )        
    )
    (if (= i 3)
        (dotimes (k (- vk_value 1)) 
            (setf proposed_length (+ (- n vk_value) k 1))
            (setf current_cell_value (aref matrix j k))
            ;; if a value is a list
            ;; and this list is bigger than what we want to trim
            (if (and (listp current_cell_value) 
                    (> (list-length current_cell_value) proposed_length) )
                (setf 
                    ;; nao usei current_cell_value pq nao sei se sobreescreve na matriz
                    (aref matrix j k) 
                    (create_pruned_possibles proposed_length))
            )
        )        
    )
)

(defun create_pruned_possibles (n)
   (let ((list ()))
        (dotimes (i n (nreverse list))
            (push (+ 1 i) list)
        )
    )
)

; Apply initial heuristics
(defun initial_prunning (matrix vss)
    (setq vss_len 4)
    (setq n (array-dimension matrix 0))
    (dotimes (i vss_len)
        (dotimes (j n)
            (progn
                (setq current (aref vss i j))
                (if (= current 1)
                    (min_value_coordinates matrix i j n)
                )
                (if (= current n)
                    (max_value_coordinates matrix i j n)
                )
                (if (and (> current 1) (< current n))
                    (exclude_possibilites matrix i j n current)
                )
            )
        )
    )
)