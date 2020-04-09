;; Controller plateset definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plateset) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))

(define (prep-ps-rows a)
  (fold (lambda (x prev)
          (let (
                (plate_set_sys_name (result-ref x "plate_set_sys_name"))
                (plate_set_name (result-ref x "plate_set_name"))
		(descr (result-ref x "descr")))
            (cons (string-append "<tr><th><a href=\"localhost:3000/plate/getpltforps?id=" (number->string (cdr (car x))) "\">" plate_set_sys_name "</a></th><th>" plate_set_name "</th><th>" descr "</th></tr>")
		  prev)))
        '() a))




(plateset-define getps
		 (lambda (rc)
		   (let* ((ret #f)
			  (holder '())
			  (help-topic "plateset")
			  (id  (get-from-qstr rc "id"))
			  (dummy (dbi-query ciccio (string-append "select id, plate_set_sys_name, plate_set_name, descr from plate_set where project_id =" id )))
			  (ret (dbi-get_row ciccio))
			  (dummy2 (while (not (equal? ret #f))     
				    (set! holder (cons ret holder))		   
				    (set! ret  (dbi-get_row ciccio))))
			  (body  (string-concatenate  (prep-ps-rows holder)) ))      
		     (view-render "getps" (the-environment))
		     )))

