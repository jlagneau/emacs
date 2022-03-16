;; For emacs < 27
(when (version< emacs-version "27")
  (message "Emacs version < 27 do not support early-init.el. Load it manually.")
  (load (concat
         (file-name-directory load-file-name)
         "early-init")
   'noerror 'nomessage))

;; Directory structure.
(defconst lec/cached-dir (concat user-emacs-directory ".cache/")
  "Directory for cached files.")

(defconst lec/doc-dir (concat user-emacs-directory "doc/")
  "Directory where literate configuration in org-mode lies.")

(defconst lec/doc-file (concat lec/doc-dir "README.org")
  "Documentation file for the configuration.")

(defconst lec/tangled-doc-file
  (concat lec/cached-dir "tangled-configuration.el")
  "File destination for tangled code blocks from the documentation.")

;; Utility functions to handle documentation tangling.
(defun lec/--tangle-file-to-cache-dir ()
  "Tangle the org file given to cache directory after renaming it."
  (require 'org)
  (org-babel-tangle-file lec/doc-file lec/tangled-doc-file))

(defun lec/tangle-documentation ()
  "Tangle documentation configuration code-blocks."
  (interactive)
  (lec/--tangle-file-to-cache-dir))

(defun lec/tangle-current-documentation ()
  "If the the file currently edited is the documentation configuration, tangle
the code blocks."
  (interactive)
  (when (string-match lec/doc-file buffer-file-name)
    (lec/tangle-documentation)))

;; Create lec/cached-dir if it does not exists.
(when (not (file-directory-p lec/cached-dir))
  (make-directory lec/cached-dir t))

;; Tangle all Org configuration files if they do not exists,
;; or when a configuration file is modified.
(unless (file-exists-p lec/tangled-doc-file)
  (lec/tangle-documentation))
(add-hook 'after-save-hook #'lec/tangle-current-documentation)

;; Load compiled configuration files.
(load lec/tangled-doc-file)

;; Customize file locations
(setq custom-file (concat lec/cached-dir "custom.el"))
(load custom-file 'noerror 'nomessage)
