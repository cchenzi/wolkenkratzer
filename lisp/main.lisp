(setf vss_01 (make-array '(4 5) 
        :initial-contents '((0 3 3 0 0) (3 2 3 0 1) (0 2 2 2 1) (1 4 3 2 0)))
)

(setf vss_26 (make-array '(4 4) 
        :initial-contents '((4 0 0 0) (3 2 0 0) (0 2 2 0) (0 2 2 1)))
)

(setf vss_73 (make-array '(4 4) 
        :initial-contents '((0 3 0 0) (0 0 2 2) (0 2 0 0) (0 0 2 1)))
)

(setf vss_31 (make-array '(4 5) 
        :initial-contents '((3 0 2 0 1) (1 0 0 0 0) (0 0 0 1 4) (5 2 0 3 4)))
)

(setf vss_32 (make-array '(4 5) 
        :initial-contents '((0 0 2 2 0) (3 0 0 0 4) (1 0 2 4 3) (2 2 0 0 0)))
)

(setf vss_03 (make-array '(4 6) 
        :initial-contents '((4 1 2 2 3 2) (2 4 2 3 1 4) (1 3 5 2 4 2) (2 3 3 4 2 1)))
)

(setf vss_41 (make-array '(4 6) 
        :initial-contents '((2 3 2 2 1 3) (2 3 2 1 2 2) (3 1 3 2 4 2) (5 1 3 2 4 2)))
)

(setf vss_42 (make-array '(4 6) 
        :initial-contents '((3 0 0 2 2 0) (4 5 1 0 0 5) (0 0 2 2 0 4) (3 2 0 0 0 0)))
)

(setf vss_666 (make-array '(4 5) 
        :initial-contents '((3 0 2 0 1) (1 0 0 1 0) (0 0 0 1 4) (5 1 5 3 4)))
)

; (setf vss_ (make-array '(4 ) 
;         :initial-contents '(() () () ()))
; )

; Fix a value in a cell at (i, j)
(defun fix_value (matrix i j x)
    (setf (aref matrix i j) x)
)

; Check if a matrix is completly fixed
(defun is_fixed (matrix)
    (if (Null matrix)
        Nil 
        (progn
            (setq n (array-dimension matrix 0))
            (dotimes (i n)
            	(dotimes (j n)
            		(progn
                        (setq current (aref matrix i j))
                        (if (listp current)
                        	(return-from is_fixed NIL)
                        )
                    )
            	)
            )
            T
        )
    )
)

; Check if matrix not contains a empty list
(defun is_valid (matrix)
    (if (Null matrix)
        Nil 
        (progn
            (setq n (array-dimension matrix 0))
            (dotimes (i n)
            	(dotimes (j n)
            		(progn
                        (setq current (aref matrix i j))
                        (if (not current)
                			(return-from is_valid NIL)
                        )
                    )
            	)
            )
            T
        )
    )
)

(defun print_matrix (matrix)
    (if (Null matrix)
        Nil 
        (progn
            (setq n (array-dimension matrix 0))
            (setq line ())
            (dotimes (i n)
                (dotimes (j n)
                    (progn
                        (setq current (aref matrix i j))
                        (setq line (concatenate 'list (list current) line))
                    )
                )
                (print (reverse line))
                (setq line ())
            )
        )
    )
)


(defun solverWk (m vs)
    (progn
    ;(print "inicio")
    ;(print (print_matrix m))
    (initial_prunning m vs)
    (solverAuxWK m vs)
    )
)

;if is_fixed:
;    if check_it:
;        return m
;else:
;    if is_valid:
;        m1 m2 = next_matrices

(defun solverAuxWk(m vs)
    (progn
        (if (is_fixed m)
            (if (checkIt m vs)
                m
                Nil
            )
            (if (is_valid m)
                (progn
                    (setf aux (next_matrices m))
                    (setf m1 (car aux))
                    (let ((m2 (car (cdr aux))))

                    (setf resulM1 (solverAuxWk m1 vs))
                    (if (NulL resulM1)
                        (solverAuxWk m2 vs)
                        resulM1
                    ))
                )
                Nil
            )
        )
    )
)



(defun main()
    (load "modules/matrix-cleaning.lisp")
    (load "modules/next-matrix.lisp")
    (load "modules/init-prunning.lisp")
    (load "modules/init-matrix.lisp")
    (load "checkup.lisp")

    ; (setq t1 (current-time))
    (print"==========Solve Matrix [4x4]======")
    (print"==========#26  from janko.at=======")
    (setf m3 (init_matrix 4))
    (time (print_matrix (solverWk m3 vss_26)))
    ; (setq t2 (current-time))
    ; (setq time_spent (- t2 t1))
    ; (print "Time spent: ")
    ; (print )

    (print"==========Solve Matrix [4x4]======")
    (print"==========#73  from janko.at=======")
    (setf m3 (init_matrix 4))
    (time (print_matrix (solverWk m3 vss_73)))

    (print "==========Solve Matrix [5x5]======")
    (print "==========#01  from janko.at=======")
    (setf m3 (init_matrix 5))
    (time (print_matrix (solverWk m3 vss_01)))

    (print"==========Solve Matrix [5x5]======")
    (print"==========#31  from janko.at=======")
    (setf m3 (init_matrix 5))
    (time (print_matrix (solverWk m3 vss_31)))

    (print"==========Solve Matrix [5x5]======")
    (print"==========#32  from janko.at=======")
    (setf m3 (init_matrix 5))
    (time (print_matrix (solverWk m3 vss_32)))

    (print"==========Solve Matrix [6x6]======")
    (print"==========#03  from janko.at=======")
    (setf m3 (init_matrix 6))
    (time (print_matrix (solverWk m3 vss_03)))

    (print"==========Solve Matrix [6x6]======")
    (print"==========#41  from janko.at=======")
    (setf m3 (init_matrix 6))
    (time (print_matrix (solverWk m3 vss_41)))

    (print"==========Solve Matrix [6x6]=======")
    (print"==========#42  from janko.at=======")
    (setf m3 (init_matrix 6))
    (time (print_matrix (solverWk m3 vss_42)))
)


(main)