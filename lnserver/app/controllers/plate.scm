;; Controller plate definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plate) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys methods))

(define (prep-plt-rows a)
  (fold (lambda (x prev)
          (let (
                (plate-sys-name (result-ref x "plate_sys_name"))
		(barcode  (result-ref x "barcode") ))
            (cons (string-append "<tr><th><a href=\"localhost:3000/plate/getwellsforplt?id=" (number->string (cdr (car x))) "\">" plate-sys-name "</a></th><th>" barcode  "</th></tr>")
		  prev)))
        '() a))

(plate-define getpltforps
  (lambda (rc)
 (let* ((ret #f)
	(holder '())
	(help-topic "plate")
	(id  (get-from-qstr rc "id"))
	(dummy (dbi-query ciccio (string-append "select plate_plate_set.plate_id, plate.plate_sys_name, plate.barcode from plate, plate_plate_set where plate_plate_set.plate_id=plate.id AND plate_plate_set.plate_set_id =" id )))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))))
	(body (string-concatenate (prep-plt-rows holder))))

    (view-render "getid" (the-environment))
  )))

