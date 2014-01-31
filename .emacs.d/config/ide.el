;; ;; First activate auto-complete
(require 'auto-complete-config)
(ac-config-default)
(setq-default ac-sources '(ac-source-semantic-raw))
(global-set-key "\M-/" 'auto-complete)

;; IDE using CEDET (following CEDET 1.1 Gentle Introduction)
;; Select which submodes we want to activate
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)

;; Activate semantic
(semantic-mode 1)

;; Require semantic/ia
(require 'semantic/ia)
(require 'semantic/bovine/gcc) ;; TODO: What about other compilers?

;; semanticdb
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

;; imenu integration
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;; Enable EDE
(global-ede-mode t)

;; Minerva project mode. TODO: Need to make this general. See EDE manual
(ede-cpp-root-project "minerva"
		      :name "Minerva"
		      :file "~/code/minerva/CMakeLists.txt"
		      :include-path '("/"
				      "/src"
				      "/src/common"
				      "/src/common/meshes"
				      "/src/common/cameras"
				      "/src/common/characters"
				      "/src/common/comms"
				      "/src/common/constraints"
				      "/src/common/cvision"
				      "/src/common/data"
				      "/src/common/devices"
				      "/src/common/editors"
				      "/src/common/hci"
				      "/src/common/interfaces"
				      "/src/common/meshes"
				      "/src/common/opengl"
				      "/src/common/scenes"
				      "/src/common/skeletons"
				      "/src/common/solvers"
				      "/src/common/streams"
				      "/src/common/utilities"
				      "/src/main"
				      "/extern"
				      )
		      :system-include-path '("/usr"
					     "/usr/include"
					     "/usr/local"
					     "/usr/local/include"
					     "~/local"
					     "~/local/include"
					     "~/local/include/opencv"
					     "~/local/include/opencv2"
					     "~/local/include/opencv"
					     "~/local/include/opencv2"
					     ))

;; Qt include for Semantic
(setq qt4-base-dir "/usr/include/qt4")
(setq qt4-gui-dir (concat qt4-base-dir "/QtGui"))
(semantic-add-system-include qt4-base-dir 'c++-mode)
(semantic-add-system-include qt4-gui-dir 'c++-mode)
(add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
(defvar semantic-lex-c-preprocessor-symbol-file '()) ;; See http://emacs.1067599.n5.nabble.com/Emacs-24-semantic-C-completion-problem-td213163.html
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig-large.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qglobal.h"))

;; ;; Bind . and -> for auto completion
(defun my-c-mode-cedet-hook ()
 (local-set-key "." 'semantic-complete-self-insert)
 (local-set-key ">" 'semantic-complete-self-insert))
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

;; Always on
(global-semantic-idle-completions-mode)

;; Semantic output to auto-complete
(defun my-c-mode-cedet-hook ()
  (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

;; ;; Some shorcuts for CEDET
;; (defun cedet-shortcuts-hook ()
;;   ;; (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;;   (local-set-key [(control return)] 'semantic-ia-complete-tip)
;;   (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;;   (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
;; (add-hook 'c-mode-common-hook 'cedet-shortcuts-hook)

;; ;; Automatically starting inline completion in idle time
;; ;; (global-semantic-idle-completions-mode 1)

;; ;; ;; Require plugin for code snippets. The plugins are loaded in the beginning
;; ;; (require 'yasnippet-bundle)
;; ;; ;; Develop and keep personal snippets under ~/emacs.d/snippets/
;; ;; (setq yas/root-directory "~/.emacs.d/snippets/")
;; ;; ;; Load the snippets
;; ;; (yas/load-directory yas/root-directory)

;; Shortcut for opening header file
(global-set-key (kbd "C-x o") 'ff-find-other-file)