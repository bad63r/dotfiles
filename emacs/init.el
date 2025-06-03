; Disable defaul welcome screen
(setq inhibit-startup-message t)


(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar
(auto-fill-mode -1)         ; Disables line breaks
(setq find-file-dired nil) ; Disable to open directory in Dired Mode when searching with C-x C-F 

(setq backup-directory-alist `(("." . "~/.saves"))) ; Backup files, send them to ~/.saves
(setq make-backup-files nil)

(defun goto-myconfig ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-x e") 'goto-myconfig) ; goto my Emacs config file

; Disabled C-x C-b keybinding which can accidentaly happen
(global-unset-key (kbd "C-x C-b"))

;; Set up the visible bell
(setq visible-bell t)

(setq font-lock-maximum-decoration t)


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
    ;;(setq dashboard-banner-logo-title "your custom text")
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
  (setq helm-boring-buffer-regexp-list (list (rx "*") ))
)
(setq helm-buffer-max-length nil)
(setq helm-find-files-sort-directories t)
; Hide buffers 

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
;; (setq-default message-log-max nil)
;; (kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

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
;; if it still now showing do:
;; M-x nerd-the-icons-install-fonts
(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes
  :init (load-theme 'doom-dracula t))


(add-hook 'c-mode-hook
          (lambda ()
            (setq c-default-style "gnu"
                  c-basic-offset 8)))

(add-hook 'c++-mode-hook
          (lambda ()
            (setq c-default-style "gnu"
                  c-basic-offset 8)))


;; (use-package rainbow-delimiters
;;   :hook (prog-mode . rainbow-delimiters-mode))

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

; Fix that visual mode selection is still active after right indent
; in evil mode
(defun my/evil-shift-right ()
  (interactive)
  (evil-shift-right evil-visual-beginning evil-visual-end)
  (evil-normal-state)
  (evil-visual-restore))

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
  (define-key evil-insert-state-map (kbd "C-/") 'yas-expand) ; expand yasnippets

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

  ; Fix left and right indent issue of evil mode
  (evil-define-key 'visual global-map (kbd ">") 'my/evil-shift-right)
  (evil-define-key 'visual global-map (kbd "<") 'my/evil-shift-left)

; Fix of redo functionality in evil-mode
(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

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
  (when (file-directory-p "~/kde/src/")
    (setq projectile-project-search-path '("~/kde/src/")))
  (setq projectile-switch-project-action #'projectile-find-file-dwim))

(defun show-and-copy-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (kill-new (buffer-file-name))
  (message (buffer-file-name)))

(global-set-key (kbd "C-c b") 'show-and-copy-file-name)

; Set easy-customization file path
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

(use-package imenu-list
  :config
  (global-set-key (kbd "C-'") #'imenu-list-smart-toggle))

;; (use-package company
;;   :ensure t
;;   :config (global-company-mode 1))


(use-package yasnippet-snippets)

(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))


(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(use-package qml-mode)

(setq warning-minimum-level :emergency) ; set to display only emergency warning. it helps with qml-mode and lsp because
					; there is some warnings there when opening 


; Live syntax check; dependency for lsp-mode
(use-package flycheck)

(use-package lsp-mode
  :init 
  (setq lsp-keymap-prefix "C-c l") ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (qml-mode . lsp)
         (c++-mode . lsp)
         (c-mode . lsp)
         (cc-mode . lsp)
         ;; ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

; needed for lsp to work better/optimisation/
(setq gc-cons-threshold 100000000)



;; (use-package lsp-mode
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          (qml-mode . lsp)
;;          (c++-mode . lsp)
;;          ;; ;; if you want which-key integration
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands lsp)


;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; optionally							   ;;
;;(use-package lsp-ui :commands lsp-ui-mode)				   ;;
;; if you are helm user						   ;;
;;(use-package helm-lsp :commands helm-lsp-workspace-symbol)		   ;;
;; ;; if you are ivy user						   ;;
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)		   ;;
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)	   ;;
;; 									   ;;
;; ;; optionally if you want to use debugger				   ;;
;; (use-package dap-mode)						   ;;
;; ;; (use-package dap-LANGUAGE) to load the dap adapter for your language ;;
;; 									   ;;
;; ;; optional if you want which-key integration			   ;;
;; (use-package which-key						   ;;
;;     :config								   ;;
;;     (which-key-mode))						   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
