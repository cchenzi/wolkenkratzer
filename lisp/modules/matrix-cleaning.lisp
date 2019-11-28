; Remove from a list
(defun remove_from_list (ref_list rem_list)
    (setq n (length rem_list))
    (dotimes (i n)
        (progn
            (setq current (nth i rem_list))
            (if (check_if_in ref_list current)
                (setf ref_list (remove current ref_list))
            )
        )
    )
    ref_list
)


(defun aux_clean_line (matrix i)
    (setq n (array-dimension matrix 0))
    (progn
        (setq fixed_numbers (get_fixed_line matrix i))
        (dotimes (j n)
            (progn
                (setq current (aref matrix i j))
                (if (listp current)
                    (setf (aref matrix i j) (remove_from_list current fixed_numbers))
                )
            )
        )
    )
)

(defun aux_clean_column (matrix j)
    (setq n (array-dimension matrix 0))
    (progn
        (setq fixed_numbers (get_fixed_column matrix j))
        (dotimes (i n)
            (progn
                (setq current (aref matrix i j))
                (if (listp current)
                    (setf (aref matrix i j) (remove_from_list current fixed_numbers))
                )
            )
        )
    )
)

; Clean the possible list from rows and columns based on fixed values
(defun clean_all(matrix)
    (progn
        (clean_line matrix)
        (clean_column matrix)
    )
)

; Clean the possible list from rows based on fixed values
(defun clean_line (matrix)
    (setq n (array-dimension matrix 0))
    (dotimes (i n)
        (aux_clean_line matrix i)
    )
)

; Clean the possible list from columns based on fixed values
(defun clean_column (matrix)
    (setq n (array-dimension matrix 0))
    (dotimes (j n)
        (aux_clean_column matrix j)
    )
)


; Get fixed values from row
(defun get_fixed_line (matrix i)
    (setq n (array-dimension matrix 0))
    (setq fixeds ())
    (dotimes (j n)
        (progn
            (setq current (aref matrix i j))
            (if (not (listp current))
                (progn
                    (setq fixeds (concatenate 'list (list current) fixeds))
                )
            )
        )
    )
    fixeds
)

; Get fixed values from column
(defun get_fixed_column (matrix j)
    (setq n (array-dimension matrix 0))
    (setq fixeds ())
    (dotimes (i n)
        (progn
            (setq current (aref matrix i j))
            (if (not (listp current))
                (progn
                    (setq fixeds (concatenate 'list (list current) fixeds))
                )
            )
        )
    )
    fixeds
)

; Check if a element is in a list
(defun check_if_in (l n)
    (if (member n l) t nil)
)