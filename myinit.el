
(setq
  inhibit-startup-screen                t
  create-lockfiles                      nil
  make-backup-files                     nil
  auto-save-default                     nil
  column-number-mode                    t
  scroll-error-top-bottom               t
  show-paren-delay                      0.1
  tabs-width                            2
  js-indent-level                       2
  ruby-indent-level                     2
  use-package-verbose                   nil
  use-package-always-ensure             t
  package-enable-at-startup             nil
  sentence-end-double-space             nil
  split-width-threshold                 nil
  split-height-threshold                nil
  ring-bell-function                    'ignore
  inhibit-startup-echo-area-message     t
  frame-title-format                    '((:eval buffer-file-name))
  enable-local-variables                :all
  mouse-1-click-follows-link            t
  mouse-1-click-in-non-selected-windows t
  select-enable-clipboard               t
  mouse-wheel-scroll-amount             '(0.01)
  column-number-mode                    t
  confirm-kill-emacs                    (quote y-or-n-p)
  ns-use-native-fullscreen              nil
  ns-pop-up-frames                      nil
  line-move-visual                      t)

(setq-default
  fill-column           70
  indent-tabs-mode      nil
  truncate-lines        t
  require-final-newline t
  fringe-mode           '(4 . 2))

(defalias 'yes-or-no-p 'y-or-n-p)

(blink-cursor-mode 0)
(global-hl-line-mode t)
(show-paren-mode t)
(delete-selection-mode 1)
(cua-mode 1)
(set-face-attribute 'default nil
                    :family "Fira Code"
                    :height 150
                    :weight 'thin
                    :width 'normal)
(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               (123 . ".\\(?:-\\)")
               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
               )
             ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :init
      (progn
        (exec-path-from-shell-initialize))))

(if window-system
    (progn
      (tool-bar-mode -1)
        (scroll-bar-mode -1)
        (add-to-list 'initial-frame-alist '(width . 150))
        (add-to-list 'initial-frame-alist '(height . 50))
        (add-to-list 'default-frame-alist '(width . 150))
        (add-to-list 'default-frame-alist '(height . 50))))

(use-package robe
  :init
    (add-hook 'ruby-mode-hook 'robe-mode t))

(use-package inf-ruby
  :config
  (add-hook 'ruby-mode-hook #'inf-ruby-minor-mode))

(use-package projectile-rails
  :config
  (projectile-rails-global-mode t))

(use-package ruby-end
  :config
  (add-hook 'ruby-mode-hook #'ruby-end-mode))

(use-package flymake-ruby
  :config
  (add-hook 'ruby-mode-hook 'flymake-ruby-load))

(use-package slime
  :mode "\\.lisp%"
  :init
    (add-hook 'lisp-mode-hook 'slime-mode)
    (progn
      (setq inferior-lisp-program "/usr/local/Cellar/sbcl/1.3.21/bin/sbcl")
      (setq slime-contribs '(slime-fancy))))

(use-package js2-mode
  :mode "\\.js$"
  :init
    (add-hook 'js-mode-hook  'js2-minor-mode t)
    (add-hook 'js2-mode-hook 'js2-imenu-extras-code t)
  :bind (
    :map js2-mode-map
      ("M-. " . nil)))

(use-package js2-refactor
  :init
    (add-hook 'js2-mode-hook 'js2-refactor-mode t))

(use-package xref-js2
  :init
   (add-hook 'js2-mode-hook (lambda ()
   (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))))

(use-package indium
  :init
    (add-hook 'js2-mode-hook 'indium-interactive-mode-hook))

(use-package company
  :init
    (add-hook 'after-init-hook 'global-company-mode)
    (add-to-list 'company-backends 'company-robe))
(use-package company-tern
  :init
    (add-to-list 'company-backends 'company-tern)
    (add-hook 'js2-mode-hook (lambda ()
                             (tern-mode t)
                             (company-mode t)))
  :bind (
    :map tern-mode-keymap
      ("M-." . nil)
      ("M-," . nil)))

(use-package smartparens
  :init
    (smartparens-global-mode t))

(use-package web-mode
  :init
    (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode)))

(use-package projectile
  :init
  (progn
    (projectile-global-mode)
    (setq projectile-completion-system 'ido) ;; alternatively, 'helm
    (setq projectile-use-git-grep t)))

(use-package helm
  :init
  (progn
    (setq helm-follow-mode t)
    (setq helm-full-frame nil)
    ;; (setq helm-split-window-in-side-p nil)
    (setq helm-split-window-in-side-p t)
    (setq helm-split-window-default-side 'below)
    (setq helm-buffer-max-length nil)

    (setq helm-buffers-fuzzy-matching t)
    (setq helm-M-x-always-save-history nil)

    (setq helm-find-files-actions '
          (("Find File" . helm-find-file-or-marked)
           ("View file" . view-file)
           ("Zgrep File(s)" . helm-ff-zgrep)))

    (setq helm-type-file-actions
          '(("Find File" . helm-find-file-or-marked)
            ("View file" . view-file)
            ("Zgrep File(s)" . helm-ff-zgrep)))

    (add-to-list 'display-buffer-alist
                 `(,(rx bos "*helm" (+ anything) "*" eos)
                   (display-buffer-in-side-window)
                   (side            . bottom)
                   (window-height . 0.3)))))

(use-package ido
  :init
    (progn
      (defun ido-M-x ()
        (interactive)
          (call-interactively
            (intern
              (ido-completing-read
                "M-x "
                  (all-completions "" obarray 'commandp)))))

  (ido-mode 1)
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point nil)
  (setq ido-create-new-buffer 'always)
  (setq ido-max-prospects 20)
  (setq ido-auto-merge-work-directories-length -1)))

(use-package ido-vertical-mode
  :init
    (progn
      (ido-vertical-mode 1)
        (defun bind-ido-keys ()
          (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
          (define-key ido-completion-map (kbd "C-p")   'ido-prev-match))
        (add-hook 'ido-setup-hook 'bind-ido-keys)))

(use-package magit)

(use-package git-gutter
  :config
    (global-git-gutter-mode))

(use-package ox-reveal
  :config
    (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
    (setq org-reveal-mathjax t))
(use-package htmlize)
(use-package markdown-mode)

(use-package org
  :config
    (setq org-log-done t))

(use-package linum
  :init
    (global-linum-mode 1)
    (setq linum-format "%4d "))

(use-package whitespace
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook))
    (add-hook hook #'whitespace-mode))
  (add-hook 'before-save-hook #'whitespace-cleanup)
  :config
  (setq whitespace-line-column 80) ;; limit line length
  (setq whitespace-style '(face tabs empty trailing lines-tail)))

(use-package indent-guide
  :config
  (indent-guide-global-mode))

(use-package which-key
  :config
    (which-key-mode))

(use-package iedit)

(use-package evil
  :init
    (progn
    (setq evil-default-cursor t))
  :config
    (evil-mode 1))

(use-package evil-repeat
  :bind (
    :map evil-normal-state-map
      ("M-. " . nil)
    :map evil-visual-state-map
      ("M-. " . nil)))

(use-package evil-leader
  :init
    (global-evil-leader-mode
  (progn
    (evil-leader/set-leader "<SPC>")

    (evil-leader/set-key
      "g" 'magit-status )

    (evil-leader/set-key
      "o a" 'org-agenda)

    (evil-leader/set-key
      "e" 'iedit-mode)

    (evil-leader/set-key
      "o p" 'projectile-switch-project)

    (evil-leader/set-key
      "f f" 'projectile-find-file)
    (evil-leader/set-key
      "f w" 'projectile-find-file-other-window)
    (evil-leader/set-key
      "p r" 'projectile-replace)
    (evil-leader/set-key
      "p S" 'projectile-save-project-buffers)

    (evil-leader/set-key
      "q q" 'delete-window)

    (evil-leader/set-key-for-mode 'ruby-mode
      "g d" 'robe-jump)

    (evil-leader/set-key-for-mode 'ruby-mode
      "f m" 'projectile-rails-find-model)
    (evil-leader/set-key-for-mode 'ruby-mode
      "f M" 'projectile-rails-find-current-model)
    (evil-leader/set-key-for-mode 'ruby-mode
      "f c" 'projectile-rails-find-controller)
    (evil-leader/set-key-for-mode 'ruby-mode
      "f C" 'projectile-rails-find-current-controller)
    (evil-leader/set-key-for-mode 'ruby-mode
      "f v" 'projectile-rails-find-view)
    (evil-leader/set-key-for-mode 'ruby-mode
      "f V" 'projectile-rails-find-current-view)
    (evil-leader/set-key-for-mode 'ruby-mode
      "r ! s" 'projectile-rails-server)
    (evil-leader/set-key-for-mode 'ruby-mode
      "r ! g" 'projectile-rails-generate))))
(use-package evil-surround
  :config
    (global-evil-surround-mode))

(use-package evil-escape
  :init
    (setq-default evil-escape-key-sequence "jk")
  :config
    (evil-escape-mode))

(use-package evil-indent-textobject)
(use-package evil-lion
  :bind (
    :map evil-normal-state-map
      ("g l " . evil-lion-left)
      ("g L " . evil-lion-right)
    :map evil-visual-state-map
      ("g l " . evil-lion-left)
      ("g L " . evil-lion-right))
  :config
    (evil-lion-mode))

(use-package seoul256-theme)
(use-package monokai-theme
  :init
    (load-theme 'monokai t))

(use-package powerline
      :config
    (setq powerline-display-buffer-size nil)
    (setq powerline-display-mule-info nil)
    (setq powerline-display-hud nil)
    (when (display-graphic-p)
      (powerline-default-theme)
      (remove-hook 'focus-out-hook 'powerline-unset-selected-window)))

(use-package all-the-icons)