; Aux function to create a possible list from 1 to n
(defun create_possible_list (n)
   (let ((list ()))
        (dotimes (i n (nreverse list))
            (push (+ 1 i) list)
        )
    )
)


(defun auxCountRow (row greatest)
    (if (null row)
        0
        (if (> greatest (car row))
            (auxCountRow (cdr row) greatest)    
            (+ 1 (auxCountRow (cdr row) (car row)))
        )
    )
)

;; Receives wkRow  outputs count of visualizations observed
(defun countRow (row)
    (auxCountRow row 0)
)

(defun validateView (row expectedVis)
    (if (= 0 expectedVis)
        T    
        (= expectedVis (countRow row))
    )
)


(defun getRow(matriz Row)
    (auxRow matriz Row 0)
)

(defun auxRow(matriz Row i)
    (cond
        ((< i (array-dimension matriz 0)) 
            (cons (aref matriz Row i) (auxRow matriz Row (+ i 1))) )
        ( () )
    )
)    

(defun getColuna(matriz coluna)
    (auxColuna matriz coluna 0)
)

(defun auxColuna(matriz coluna i)
    (cond
        ((< i (array-dimension matriz 0)) 
            (cons (aref matriz i coluna) (auxColuna matriz coluna (+ i 1))) )
        ( () )
    )
)    

(defun horizontalCheck(matriz vis)
    (dotimes (i (array-dimension matriz 0))
        (progn
            (setf thisrow (getRow matriz i))
            (if (not 
                    (and 
                        (validateView thisrow (aref vis 3 i))
                        (validateView (nreverse thisrow) (aref vis 1 i))
                    )
                )
                (return-from horizontalCheck NIL)
            )    
        )
    )
    (return-from horizontalCheck T)
)


(defun verticalCheck(matriz vis)
    (dotimes (i (array-dimension matriz 0))
        (progn
            (setf thisCol (getColuna matriz i))
            (if (not 
                    (and 
                        (validateView thisCol (aref vis 0 i))
                        (validateView (nreverse thisCol) (aref vis 2 i))
                    )
                )
                (return-from verticalCheck NIL)
            )    
        )
    )
    (return-from verticalCheck T)
)

(defun checkIt(matriz vis)
    (and 
        (horizontalCheck matriz vis)
        (verticalCheck matriz vis)
    )
)

; (defun main()
;     (setf exVis1 (make-array '(4 3) 
;         :initial-contents '((0 2 0) (3 2 0) (2 0 0) (1 0 2)))
;     )

;     (setf exVis2 (make-array '(4 3) 
;         :initial-contents '((1 2 0) (3 2 0) (2 0 1) (1 0 2)))
;     )

;     (setf exMatriz1 (make-array '(3 3)
;         :initial-contents '( (3  2  1) (1  3  2) (2  1  3) ))
;     )

;     (setf exMatriz2 (make-array '(3 3)
;         :initial-contents '( (1  2  3) 
;                             (3  1  2) 
;                             (2  3  1) ))
;     )


;     ;; (setq SIZE 3)
;     ;; (setq m1 (init_matrix SIZE))

;     ;; (write-line (write-to-string (print_matrix m1)))
    
;     ;; (write-line (write-to-string vss_1))

;     (write-line (write-to-string "Count Tests"))
;     (write-line (write-to-string (countRow '(1 2 3 4 5))))
;     (write-line (write-to-string (countRow '(3 2 1 4 5))))
;     (write-line (write-to-string (countRow '(3 2 1 5 4))))

;     (write-line (write-to-string "Validate counting Tests"))
;     (write-line (write-to-string (validateView '(1 2 3 4 5) 5)))
;     (write-line (write-to-string (validateView '(3 2 1 4 5) 3)))
;     (write-line (write-to-string (validateView '(3 2 1 5 4) 2)))
;     (write-line (write-to-string (validateView '(3 2 1 5 4) 0)))
;     (write-line (write-to-string (validateView '(1 2 3 4 5) 1)))
;     (write-line (write-to-string (validateView '(3 2 1 4 5) 5)))
;     (write-line (write-to-string (validateView '(3 2 1 5 4) 8)))


;     (write-line (write-to-string exMatriz1))
;     (write-line (write-to-string exVis1))

;     (print "Rows")
;     (print (getRow exMatriz1 0))
;     (print (getRow exMatriz1 1))
;     (print (getRow exMatriz1 2))

;     (print "Colunas")    
;     (print (getColuna exMatriz1 0))
;     (print (getColuna exMatriz1 1))
;     (print (getColuna exMatriz1 2))

;     (print "Revert Row")
;     (print (nreverse (getRow exMatriz1 0)))

;     (print "horizontalCheck")
;     (print (horizontalCheck exMatriz1 exVis1))
;     (print (horizontalCheck exMatriz2 exVis2))

;     (print "verticalCheck")
;     (print (verticalCheck exMatriz1 exVis1))
;     (print (verticalCheck exMatriz2 exVis2))

;     (print "Check it")
;     (print (checkIt exMatriz1 exVis1))
;     (print (checkIt exMatriz2 exVis2))
; )
