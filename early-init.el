;; Emacs 27.1 introduced early-init.el, which is run before init.el

;; Redirect eln-cache files into appropriate directory.
(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (concat user-emacs-directory ".cache/eln/")))

;; Disable visual junk.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t
      ring-bell-function 'ignore
      ad-redefinition-action 'accept)
(setq-default frame-title-format '("%b"))

;; Font.
(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 100)
(set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font" :height 100)
(set-face-attribute 'variable-pitch nil :font "NotoSansDisplay Nerd Font" :height 100)

;; Colors.
(add-to-list 'default-frame-alist '(foreground-color . "#d6d6d4"))
(add-to-list 'default-frame-alist '(background-color . "#1c1e1f"))

;; Modeline.
(set-face-foreground 'mode-line "#d6d6d4")
(set-face-background 'mode-line "#2d2e2e")
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)
(setq mode-line-format "Initializing GNU/Emacs...")

;; Scratch buffer.
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)

;; Maximized frame.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Speedup by disabling the garbage collector and the packages at startup.
(setq gc-cons-threshold most-positive-fixnum
      native-comp-deferred-compilation t
      warning-minimum-level :error
      package-enable-at-startup nil
      load-prefer-newer noninteractive)

;; locale and input method.
(set-language-environment "UTF-8")
(setq default-input-method nil)
