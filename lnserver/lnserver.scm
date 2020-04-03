(define-module (lnserver lnserver)
  #:use-module (lnserver methods))


(use-modules (artanis artanis)(artanis utils) (ice-9 local-eval) (srfi srfi-1)
             (artanis irregex)(dbi dbi) (ice-9 textual-ports)(web uri))
(init-server)

;;(load "./methods.scm")



(get "/getallprojects" #:raw-sql  "select id, project_sys_name, project_name, descr from project" 
     (lambda (rc)
       (let* ((current-toplevel  (getcwd))	 
	      (page-title "<table><caption><h1>All Projects</h1></caption><tr><th>Project</th><th>Name</th><th>Description</th></tr>")
	      (mtable  (:raw-sql rc 'all))
	      (top-level ".")
	      (body (string-append (get-header2 "project") page-title (string-concatenate (prep-project-rows mtable)) footer)))
;;	 (tpl->response "project.tpl" (the-environment))
	 (tpl->response "lnserver/tpl/project.tpl" (the-environment) )
	 )
       ))


(get "/getpsforprj?" #:conn #t
     (lambda (rc)
       (let* ((ret #f)
	      (holder '())
	      (top-level ".")
	      (id  (get-from-qstr rc "id"))
	      (page-title (string-append "<table><caption><h1>Plate Sets for PRJ-"id "</h1></caption><tr><th>Project</th><th>Name</th><th>Description</th></tr>"))
	      (dummy (dbi-query ciccio (string-append "select id, plate_set_sys_name, plate_set_name, descr from plate_set where project_id =" id )))
	      (ret (dbi-get_row ciccio))
	      (dummy2 (while (not (equal? ret #f))     
			(set! holder (cons ret holder))		   
			(set! ret  (dbi-get_row ciccio))))
	     (body (string-append header page-title (string-concatenate  (prep-ps-rows holder)) footer)))      
	     
		 (tpl->response "lnserver/tpl/plate-set.tpl" (the-environment))

	 )))


(get "/getpltforps?" #:conn #t
     (lambda (rc)
       (let* ((id  (get-from-qstr rc "id"))
	      (plates (get-plates-for-psid id))
	      (assay-runs (get-assay-runs-for-psid id))
	      (body (string-append header plates assay-runs footer)))      
	     
		 (tpl->response "lnserver/tpl/plate.tpl" (the-environment))

	 )))


(get "/getlayouts?" #:conn #t
     (lambda (rc)
       (let* ((help-link "localhost:4000/software/layouts")
	      (help-text "Help with Layouts")
	      (body (get-all-layouts)))
		 (tpl->response "lnserver/tpl/layouts.tpl" (the-environment)))))



;; prepare the tab delimitted file for graphing
(get "/getlayoutforid?" #:conn #t
     (lambda (rc)
       (let* ((help-link "localhost:4000/software/layouts")
	      (help-text "Help with Layouts")
	      (id  (get-from-qstr rc "id"))
	      (body (get-layout-for-id id)))
		 (tpl->response "lnserver/tpl/layouts.tpl" (the-environment)))))


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
		 (tpl->response "lnserver/tpl/individual-layouts.tpl" (the-environment)))))


(get "/gethelp?" #:conn #t
     (lambda (rc)
       (let* ((topic  (get-from-qstr rc "topic")))
	   	 (redirect-to rc (string->uri (string-append help-url topic)) ))))

;; (get "/gethelp?" #:conn #t
;;      (lambda (rc)
;;        (let* ((topic  (get-from-qstr rc "topic")))
;; 	   	 (redirect-to rc (string->uri (string-append "/lnserver/public/" topic)) ))))


(run #:use-db? #t #:dbd 'postgresql #:db-username "ln_admin" 
     #:db-name "lndb" #:db-addr "127.0.0.1:6432" #:db-passwd "welcome"  #:port 3000)


