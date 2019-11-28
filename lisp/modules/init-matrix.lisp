; Create initial matrix, with all possibilites for each cell
(defun init_matrix (n)
    (make-array (list n n) :initial-element (create_possible_list n))
)

; Aux function to create a possible list from 1 to n
(defun create_possible_list (n)
   (let ((list ()))
        (dotimes (i n (nreverse list))
            (push (+ 1 i) list)
        )
    )
)