(define-module (lnserver)
  #:use-module (lnserver methods))


(use-modules (artanis artanis)(artanis utils) (ice-9 local-eval) (srfi srfi-1)
             (artanis irregex)(dbi dbi) (ice-9 textual-ports))
(init-server)

;;(load "./methods.scm")


;; prepare the tab delimitted file for graphing
(define (prep-lyt-for-r a)
  (fold (lambda (x prev)
          (let* ((format (get-c1 x))	
		 (well (get-c2 x))
		 (type (get-c3 x))
		 (row (result-ref x "row"))
		 (row-num (get-c5 x))
		 (col (result-ref x "col")))
            (cons (string-append  format "\t" well "\t" type "\t" row "\t" row-num "\t" col "\n")
		  prev)))
        '() a))


(define (get-layout-table-for-r id)
  (let* ((ret #f)
	(holder '())
	(table-header (string-append "format\twell\ttype\trow\trow.num\tcol\n"))
	(dummy (dbi-query ciccio  (string-append "select plate_format_id, by_col, well_type_id,row, row_num, col from plate_layout_name, plate_layout, well_numbers where plate_layout.well_by_col=well_numbers.by_col and plate_layout.plate_layout_name_id = plate_layout_name.id and well_numbers.plate_format=plate_layout_name.plate_format_id AND plate_layout.plate_layout_name_id =" id)))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))
		  (display ret)
		  ))
	(body (string-concatenate (prep-lyt-for-r holder))))
    (string-append table-header body )))


(define (get-data-for-layout id data-file-name)
  (let* ((data-file data-file-name)
	 (p  (open-output-file data-file)))
    (put-string p (get-layout-table-for-r id) )
    (force-output p)
    ))


(define (get-format-for-layout-id id)
  (let* ((ret #f)
	(dummy (dbi-query ciccio  (string-append "select  plate_format_id from plate_layout_name where id="  id)))
	(ret (dbi-get_row ciccio)))
    (number->string (cdar ret))))



(get "/getlayoutforid?" #:conn #t
     (lambda (rc)
       (let* ((help-link "localhost:4000/software/layouts")
	      (help-text "Help with Layouts")
	      (infile (get-rand-file-name "lyt" "txt"))
	      (outfile (get-rand-file-name "lyt" "png"))
	      (id  (get-from-qstr rc "id"))
	      (format (get-format-for-layout-id id))
	      (body (get-layout-for-id id))
	      (dummy (get-data-for-layout id infile))
	      (dummy2 (system (string-append "Rscript --vanilla ./rscripts/plot-layout.R " infile " " outfile " " format))))
		 (tpl->response "individual-layouts.tpl" (the-environment)))))

;; (system* (string-append "Rscript --vanilla ./rscripts/plot-layout.R ./mydata.txt ./out.png"))



(run #:use-db? #t #:dbd 'postgresql #:db-username "ln_admin" 
     #:db-name "lndb" #:db-addr "127.0.0.1:6432" #:db-passwd "welcome"  #:port 3000)


