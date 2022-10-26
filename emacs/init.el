
(setq package-enable-at-startup nil)
(provide 'early-init)

(setq startup/gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)
(defun startup/reset-gc () (setq gc-cons-threshold startup/gc-cons-threshold))
(add-hook 'emacs-startup-hook 'startup/reset-gc)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq native-comp-async-report-warnings-errors nil)
(straight-use-package 'use-package)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)
(setq straight-use-package-by-default t)
(setq straight-repository-branch "develop")

(global-auto-revert-mode t)
 (defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(95 . 100) '(100 . 100)))))
 (global-set-key (kbd "C-c t") 'toggle-transparency)

(use-package use-package-ensure-system-package)

(defun dvorak (&rest ignored)
  (set-input-method "programmer-dvorak"))

(use-package exec-path-from-shell
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))

(use-package emacs
  :config
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  (add-to-list 'default-frame-alist '(font . "MonoLisa 14"))
  :hook(minibuffer-setup . (lambda () (set-input-method "programmer-dvorak")))
  :custom
  (vc-follow-symlinks t)
  (enable-recursive-minibuffers t))

(use-package evil-collection
  :after evil
  :custom (evil-collection-setup-minibuffer t)
  :init (evil-collection-init))
(use-package programmer-dvorak)
(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :hook
  (evil-insert-state-entry . (lambda () (set-input-method "programmer-dvorak")))
  (isearch-mode . (lambda () (set-input-method "programmer-dvorak")))
  :config(evil-mode 1))

(use-package olivetti)
(add-hook 'org-mode-hook 'visual-line-mode)
(use-package ivy-posframe
  :custom(ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
  :config(ivy-posframe-mode))
(use-package counsel
  :bind
  ("M-x" . counsel-M-x)
  ("C-h f" . counsel-describe-function)
  ("C-h v" . counsel-describe-variable)
  ("C-c p" . counsel-fzf)
  ("C-x b" . counsel-switch-buffer))
(use-package company
  :after counsel
  :bind (:map prog-mode-map
         ("C-i" . company-indent-or-complete-common)
         ("C-M-i" . counsel-company))
  :hook (prog-mode . company-mode))
(use-package markdown-mode)
(use-package lsp-mode
  :init(setq lsp-keymap-prefix "C-l")
  :hook((python-mode . lsp))
  :commands lsp)
;; (use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsy-ivy-workspace-symbol)

(use-package magit)

(use-package doom-modeline
  :custom
  (doom-modeline-time t)
  :hook(after-init . doom-modeline-mode))

(use-package cdlatex
  :hook(org-mode . org-cdlatex-mode))
(use-package org
  :straight nil
  :hook(org-mode . (lambda ()
		     (interactive)
		     (setq buffer-face-mode-face '(:family "Space Mono"))
		     (buffer-face-mode))))

(use-package org-fragtog
  :hook(org-mode . org-fragtog-mode))
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.2))


(use-package org-download
  :after org
  :defer nil
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "images")
  (org-download-heading-lvl nil)
  (org-download-timestamp "%Y%m%d-%H%M%S_")
  (org-image-actual-width 300)
  :bind
  ("C-M-y" . org-download-clipboard)
  :config
  (require 'org-download))

(setq calendar-latitude +55)
(setq calendar-longitude +3)
(use-package moe-theme
  :config
  (setq moe-theme-highlight-buffer-id t)
  (setq moe-theme-resize-title-markdown '(1.5 1.4 1.3 1.2 1.0 1.0))
  (setq moe-theme-resize-title-org '(1.5 1.4 1.3 1.2 1.1 1.0 1.0 1.0 1.0))
  (setq moe-theme-resize-title-rst '(1.5 1.4 1.3 1.2 1.1 1.0))
  ; (setq moe-theme-mode-line-color 'purple)
  (moe-dark))


(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (setq pdf-view-use-scaling t)
  (setq-default pdf-view-display-size 'fit-page)
  (pdf-tools-install))


(use-package restart-emacs
  :commands (restart-emacs)
  :bind ("C-c r" . restart-emacs))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))


(use-package page-break-lines)
(use-package all-the-icons)

(defun config ()
  (interactive)
  (find-file (expand-file-name (concat user-emacs-directory "/init.el"))))
(bind-key "C-c f c" 'config)
(bind-key "C-c f f" #'(lambda () ""
			(interactive)
			(find-file "~/Documents/knowledge.org")))
(bind-key "C-l" #'(lambda () ""
		    (interactive)
		    (find-file "~/Documents/knowledge.org")
		    (counsel-org-goto)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(exec-path
   '("/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "/opt/homebrew/bin"))
 '(safe-local-variable-values
   '((Eval olivetti-mode)
     (org-download-image-dir . \./knowledge/)))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
