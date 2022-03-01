; Disable defaul welcome screen
(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

(setq backup-directory-alist `(("." . "~/.saves"))) ; Backup files, send them to ~/.saves

;; Set up the visible bell
(setq visible-bell t)


;; Disable "_" as word spliter in syntax table
(add-hook 'after-change-major-mode-hook
          (lambda ()
            (modify-syntax-entry ?_ "w")))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; Enable smooth scrolling
(setq scroll-step 1)
;;(setq scroll-margin 1)

;; Display line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable display line numbers in some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
		helm-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

; emacs welcoming screen
(use-package dashboard
    :ensure t
    :diminish dashboard-mode
    :config
    (setq dashboard-banner-logo-title "your custom text")
    (setq dashboard-startup-banner "/path/to/image")
    (setq dashboard-items '((recents  . 10)
                            (bookmarks . 10)))
    (dashboard-setup-startup-hook))



(defun helm-occur-insert-symbol-regexp ()
    (interactive)
    (helm-set-pattern (concat "\\_<" helm-input "\\_>")))

(use-package helm
  :diminish ;;keeps helm out of line mode. it is there but invisible 
  :bind(("C-x C-f" . helm-find-files)
	("M-x" . helm-M-x)
	("C-x b" . helm-buffers-list)
	("C-x s" . helm-occur)
	("C-x a" . helm-multi-swoop-all)
	:map helm-map
	("C-j" . helm-next-line)
	("C-k" . helm-previous-line)
	("C-z" . helm-select-action)
	("TAB" . helm-execute-persistent-action)
  	:map helm-occur-map
	("TAB" . helm-occur-insert-symbol-regexp))
  :config
  (helm-mode 1)
)
(setq helm-buffer-max-length nil)
(setq helm-find-files-sort-directories t)

(use-package helm-swoop
  :bind(
  	:map helm-occur-map
	     ("TAB" . helm-occur-insert-symbol-regexp))
)


;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts
(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes
  :init (load-theme 'doom-dracula t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))


(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode)
  (require 'helm)
  :custom ((projectile-completion-system 'helm))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/github/")
    (setq projectile-project-search-path '("~/github")))
  (setq projectile-switch-project-action #'projectile-find-file-dwim))


(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package elpy								   ;;	        ;;
;;   :custom									   ;;	        ;;
;;   (elpy-rpc-virtualenv-path 'current)					   ;;	        ;;
;;   (elpy-shell-display-buffer-after-send t)					   ;;	        ;;
;;   (python-shell-interpreter "python3")					   ;;	        ;;
;;   (elpy-rpc-python-command "python3")					   ;;	        ;;
;;   :init (advice-add 'python-mode :before 'elpy-enable)			   ;;	        ;;
;;   :config									   ;;	        ;;
;;   (setenv "PYTHONBREAKPOINT" "ipdb.set_trace")				   ;;	        ;;
;;   (add-hook 'elpy-mode-hook (lambda () (electric-indent-local-mode -1)))	   ;;	        ;;
;;   (add-hook 'elpy-mode-hook (lambda () (elpy-shell-toggle-dedicated-shell 1)))) ;;	        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; set italic, bold more beautiful in org mode
(setq org-hide-emphasis-markers t)

; make lists more beautiful in org mode
(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

; make bulets more beautiful in org mode
(use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


