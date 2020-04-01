(define-module (lnserver methods)
  #:export (get-rand-file-name
	    ciccio
	    header
	    get-c1
	    ))

;; artanis config: /etc/artanis/artanis.conf
;; pgbouncer -d ./syncd/pgbouncer.ini
;; psql -U ln_admin -p 6432 -d pgbouncer -h 127.0.0.1
;; psql -U ln_admin -p 6432 -d lndb -h 127.0.0.1
;; guix environment --manifest=./environment.scm --pure
;; guile -s ./lnserver3.scm

;; https://github.com/UMCUGenetics/guix-documentation/blob/master/for-bioinformaticians/guix-for-bioinformaticians.md

(define (get-rand-file-name pre suff)
  (string-append "./tmp/" pre "-" (number->string (random 10000000000000000000000)) "." suff))


(define ciccio (dbi-open "postgresql" "ln_admin:welcome:lndb:socket:192.168.1.11:5432"))


(define header "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">
<html>
  <head>
 <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />
    <title>LIMS*Nucleus </title>
    <link rel=\"alternate\" type=\"application/atom+xml\" title=\"Atom 1.0\" href=\"atom/1\" />
    <link rel=\"stylesheet\" type=\"text/css\" media=\"screen\" href=\"css/common.css\" />
    
    </head>
<!-- Side navigation -->
<div class=\"sidenav\">
<img src=\"img/las-nav-bar.png\" alt=\"Laboratory Automation Solutions\" style=\"width:120px;height:180px;\">
  <a href=\"\">Projects</a>
  <a href=\"\">Layouts</a>
  <a href=\" <%= help-link  %>   \">HELP</a>
  <a href=\"http://labsolns.com/software/toc\">TOC</a>
  <a href=\"mailto:info@labsolns.com\">Contact</a>
</div>
<div class=\"main\">
")


(define footer "</div></html>")

(define (prep-project-rows a)
  (fold (lambda (x prev)
          (let (
                (project_sys_name (result-ref x "project_sys_name"))
                (project_name (result-ref x "project_name"))
		(descr (result-ref x "descr")))
            (cons (string-append "<tr><th><a href=\"localhost:3000/getpsforprj?id=" (number->string (cdr (car x))) "\">" project_sys_name "</a></th><th>" project_name "</th><th>" descr "</th></tr>")
		  prev)))
        '() a))

;; artanis result-ref only works with strings
;; get a numeric by column and convert to string
(define (get-c1 x) (number->string (cdar x)))
(define (get-c2 x) (number->string (cdar (cdr x))))
(define (get-c3 x) (number->string (cdar (cddr x))))
(define (get-c4 x) (number->string (cdar (cdddr x))))
(define (get-c5 x) (number->string (cdar (cddddr x))))
(define (get-c6 x) (number->string (cdar (cdr (cddddr x)))))
(define (get-c7 x) (number->string (cdar (cddr (cddddr x)))))
(define (get-c8 x) (number->string (cdar (cdddr (cddddr x)))))
(define (get-c9 x) (number->string (cdar (cddddr (cddddr x)))))
(define (get-c10 x) (number->string (cdar (cdr (cddddr (cddddr x))))))
(define (get-c11 x) (number->string (cdar (cddr (cddddr (cddddr x))))))
(define (get-c12 x) (number->string (cdar (cdddr (cddddr (cddddr x))))))
(define (get-c13 x) (number->string (cdar (cddddr (cddddr (cddddr x))))))
(define (get-c14 x) (number->string (cdar (cdr (cddddr (cddddr (cddddr x)))))))
(define (get-c15 x) (number->string (cdar (cddr (cddddr (cddddr (cddddr x)))))))
(define (get-c16 x) (number->string (cdar (cdddr (cddddr (cddddr (cddddr x)))))))
(define (get-c17 x) (number->string (cdar (cddddr (cddddr (cddddr (cddddr x)))))))



(get "/getallprojects" #:raw-sql  "select id, project_sys_name, project_name, descr from project" 
     (lambda (rc)
       (let* ((current-toplevel  (getcwd))	 
	      (page-title "<table><caption><h1>All Projects</h1></caption><tr><th>Project</th><th>Name</th><th>Description</th></tr>")
	      (mtable  (:raw-sql rc 'all))
	      (body (string-append header page-title (string-concatenate (prep-project-rows mtable)) footer)))
;;	 (tpl->response "project.tpl" (the-environment))
	 (tpl->response "project.tpl" (the-environment) )
	 )
       ))


(define (prep-ps-rows a)
  (fold (lambda (x prev)
          (let (
                (plate_set_sys_name (result-ref x "plate_set_sys_name"))
                (plate_set_name (result-ref x "plate_set_name"))
		(descr (result-ref x "descr")))
            (cons (string-append "<tr><th><a href=\"localhost:3000/getpltforps?id=" (number->string (cdr (car x))) "\">" plate_set_sys_name "</a></th><th>" plate_set_name "</th><th>" descr "</th></tr>")
		  prev)))
        '() a))

(get "/getpsforprj?" #:conn #t
     (lambda (rc)
       (let* ((ret #f)
	      (holder '())
	      (id  (get-from-qstr rc "id"))
	      (page-title (string-append "<table><caption><h1>Plate Sets for PRJ-"id "</h1></caption><tr><th>Project</th><th>Name</th><th>Description</th></tr>"))
	      (dummy (dbi-query ciccio (string-append "select id, plate_set_sys_name, plate_set_name, descr from plate_set where project_id =" id )))
	      (ret (dbi-get_row ciccio))
	      (dummy2 (while (not (equal? ret #f))     
			(set! holder (cons ret holder))		   
			(set! ret  (dbi-get_row ciccio))))
	     (body (string-append header page-title (string-concatenate  (prep-ps-rows holder)) footer)))      
	     
		 (tpl->response "plate-set.tpl" (the-environment))

	 )))


(define (prep-plt-rows a)
  (fold (lambda (x prev)
          (let (
                (plate-sys-name (result-ref x "plate_sys_name"))
		(barcode  (result-ref x "barcode") ))
            (cons (string-append "<tr><th><a href=\"localhost:3000/getwellsforplt?id=" (number->string (cdr (car x))) "\">" plate-sys-name "</a></th><th>" barcode  "</th></tr>")
		  prev)))
        '() a))


(define (get-plates-for-psid id)
  (let* ((ret #f)
	(holder '())
	(table-header (string-append "<table><caption><h1>Plates for PS-" id "</h1></caption><tr><th>Plate</th><th>Barcode</th></tr>"))
	(dummy (dbi-query ciccio (string-append "select plate_plate_set.plate_id, plate.plate_sys_name, plate.barcode from plate, plate_plate_set where plate_plate_set.plate_id=plate.id AND plate_plate_set.plate_set_id =" id )))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))))
	(body (string-concatenate (prep-plt-rows holder))))
    (string-append table-header body "</table>")))


(define (prep-ar-rows a)
  (fold (lambda (x prev)
          (let (
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
		(assay-run-name (result-ref x "assay_run_name"))
		(descr (result-ref x "descr"))
		(assay-type-name (result-ref x "assay_type_name"))
		(sys-name (result-ref x "sys_name"))
		(name (result-ref x "name"))
		)
            (cons (string-append "<tr><th><a href=\"localhost:3000/gethlforar?id=" (number->string (cdr (car x))) "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" descr "</th><th>" assay-type-name "</th><th>" sys-name "</th><th>" name "</th><tr>")
		  prev)))
        '() a))


(define (get-assay-runs-for-psid id)
  (let* ((ret #f)
	(holder '())
	(table-header (string-append "<table><caption><h1>Assay Runs for PS-" id "</h1></caption><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr>"))
	(dummy (dbi-query ciccio (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND plate_set_id =" id )))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))))
	(body (string-concatenate (prep-ar-rows holder))))
    (string-append table-header body "</table>")))



(get "/getpltforps?" #:conn #t
     (lambda (rc)
       (let* ((id  (get-from-qstr rc "id"))
	      (plates (get-plates-for-psid id))
	      (assay-runs (get-assay-runs-for-psid id))
	      (body (string-append header plates assay-runs footer)))      
	     
		 (tpl->response "plate.tpl" (the-environment))

	 )))

(define (prep-lyt-rows a)
  (fold (lambda (x prev)
          (let* ((id (get-c1 x))
                (sys-name (result-ref x "sys_name"))
		(name (result-ref x "name"))
		(descr (result-ref x "descr"))
		(plate-format-id (get-c5 x))
		(replicates (get-c6 x))
		(targets (get-c7 x))
		(use-edge (get-c8 x))
		(num-controls (get-c9 x))
		(unknown-n (get-c10 x))
		(control-loc (result-ref x "control_loc"))
		(source-dest (result-ref x "source_dest"))
		(id-html (if (string=? "source" source-dest)
			     (string-append "<a href=\"localhost:3000/getlayoutforid?id=" id "\">" sys-name "</a>")
			     sys-name)))
            (cons (string-append "<tr><th>" id-html "</th><th>" name "</th><th>" descr "</th><th>"   plate-format-id "</th><th>" replicates "</th><th>" targets "</th><th>"  use-edge "</th><th>" num-controls "</th><th>" unknown-n "</th><th>" control-loc "</th><th>" source-dest "</th><tr>")
		  prev)))
        '() a))


(define (get-all-layouts)
  (let* ((ret #f)
	 (holder '())
	 (help-link "localhost:4000/software/layouts")
	 (help-text "Help for Layouts")
	(table-header "<table><caption><h1>Plate Layouts</h1></caption><tr><th>ID</th><th>Name</th><th>Description</th><th>Format</th><th>Sample N</th><th>Target N</th><th>Edge?</th><th>N Controls</th><th>Unk N</th><th>Location</th><th>src/dest</th></tr>")
	(dummy (dbi-query ciccio  "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name"))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))
		  ))
	(body (string-concatenate (prep-lyt-rows holder))))
    (string-append table-header body "</table>")))


(get "/getlayouts?" #:conn #t
     (lambda (rc)
       (let* ((help-link "localhost:4000/software/layouts")
	      (help-text "Help with Layouts")
	      (body (get-all-layouts)))
		 (tpl->response "layouts.tpl" (the-environment)))))



(define (get-layout-for-id id)
  (let* ((ret #f)
	(holder '())
	(table-header (string-append "<table><caption><h1>Plate Layouts for Source LYT-" id "</h1></caption><tr><th>ID</th><th>Name</th><th>Description</th><th>Format</th><th>Sample N</th><th>Target N</th><th>Edge?</th><th>N Controls</th><th>Unk N</th><th>Location</th><th>src/dest"))
	(dummy (dbi-query ciccio  (string-append "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name where id=" id)))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))
		  ))
	(body (string-concatenate (prep-lyt-rows holder))))
    (string-append table-header body "</table>")))






(get "/getlayoutforid?" #:conn #t
     (lambda (rc)
       (let* ((help-link "localhost:4000/software/layouts")
	      (help-text "Help with Layouts")
	      (id  (get-from-qstr rc "id"))
	      (body (get-layout-for-id id)))
		 (tpl->response "layouts.tpl" (the-environment)))))
