(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helm-ag counsel request eglot ace-window org-pomodoro helm-flymake flymake-flycheck marginalia selectrum-prescient selectrum dumb-jump flycheck-eglot flycheck-google-cpplint flycheck-kotlin kotlin-mode android-env android-mode ivy-todo projectile-ripgrep ivy-yasnippet ivy-file-preview ivy-fuz ivy-xref ivy-searcher ivy ag helm-fuzzy-find helm-searcher helm flycheck lsp-ui lsp-mode neotree projectile darcula-theme magit which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-face-attribute 'default nil :font "JetBrainsMono NFP" :height 120)

(which-key-mode)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))


(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

(tool-bar-mode -1)
(menu-bar-mode -1)

;; Exibir número da linha
(global-display-line-numbers-mode t)

;; Destacar linha selecionada
(global-hl-line-mode t)


;; Remover scrollbar vertical
(scroll-bar-mode -1)

;; Remover scrollbar horizontal
(horizontal-scroll-bar-mode -1)

(require 'dashboard)
(dashboard-setup-startup-hook)
;;(setq dashboard-startup-banner 'logo) ;; Você pode alterar isso conforme desejar

(setq dashboard-items '((recents . 5)
                        (projects . 5)))


(global-set-key (kbd "C-x s") 'magit-status)

;; set theme
(load-theme 'darcula t)

(setq inhibit-startup-screen t)

;; Ativar o Projectile
(projectile-mode +1)
;;(setq projectile-completion-system 'ivy)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; Ativar o Neotree
(require 'neotree)
(global-set-key (kbd "C-x n") 'neotree-toggle)

(ivy-mode 1)
(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))

(setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)


;; Ativar o lsp-mode
;;(require 'lsp-mode)
;;(add-hook 'prog-mode-hook #'lsp)

;; Ativar o lsp-ui
;;(require 'lsp-ui)
;;(add-hook 'lsp-mode-hook #'lsp-ui-mode)

;; Ativar o flycheck
;;(require 'flycheck)
;;(global-flycheck-mode)
;;

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-height 10
        ivy-count-format "(%d/%d) "))

(use-package counsel
  :ensure t
  :bind
  (("C-x b" . counsel-switch-buffer)))

(require 'ace-window)

(global-set-key (kbd "C-x o") 'ace-window)

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)

(setq-default fill-column 80)

(setq initial-frame-alist
      '((width . 205)    ; Largura da janela em caracteres
        (height . 48)))  ; Altura da janela em linhas

(defun my-update-mode-line-buffer-name ()
    "Update mode line to display full file path with highlight when unsaved changes."
      (setq-default mode-line-format
         (list
	  " " 
	  ;; File modification status
	  '(:eval (if (buffer-modified-p)
	                (propertize " Modificado " 'face '(:foreground "red"))
	           " "))
           ;;'(:eval
           ;;  (let* ((filename (buffer-file-name))
           ;;      (buffer-modified-p (buffer-modified-p))
           ;;      (file-segment (if filename
           ;;                       (propertize (file-name-nondirectory filename)
             ;;                                 'face (if buffer-modified-p
             ;;                                             '(:weight bold :foreground "yellow")
             ;;                                               '(:weight bold)))
             ;;                     "buffer sem nome")))))
	    "    "
	    ;; Current mode
	    '(:eval (propertize "%m" 'face '(:weight bold :foreground "blue")))
	    "    "
	    ; Current file name
	    '(:eval (propertize (buffer-name) 'face '(:weight bold )))
	    "    "
            ;; Git branch
            '(:eval (let ((branch (replace-regexp-in-string "\n" "" (shell-command-to-string "git symbolic-ref --short -q HEAD"))))
                     (if (stringp branch)
                         (propertize (concat " Git: " branch) 'face '(:weight bold ))
															       " ")))
            ;;(concat " " file-segment " ")))))
	    ;; Rest of the mode line
	    " -- %l:%c"
	    " -- "
            '(:eval (propertize (format-time-string "%H:%M") )))))
                    
(add-hook 'after-save-hook 'my-update-mode-line-buffer-name)
(add-hook 'after-revert-hook 'my-update-mode-line-buffer-name)
(add-hook 'find-file-hook 'my-update-mode-line-buffer-name)
(add-hook 'first-change-hook 'my-update-mode-line-buffer-name)

(use-package counsel
  :ensure t
  :bind
  (("C-x b" . counsel-switch-buffer)))

(setq counsel-switch-buffer-preview-virtual t)

(defun meu-frame-vertical ()
    "Cria um novo frame e o divide em dois verticalmente."
     (interactive)
     (let ((novo-frame (make-frame-command)))
     (modify-frame-parameters novo-frame '((name . " "))) ; Remove o título do frame
     (set-frame-parameter novo-frame 'tool-bar-lines 0) (set-frame-parameter novo-frame 'menu-bar-lines 0) ; Remove a barra de menu
     (select-frame-set-input-focus novo-frame)
     (set-frame-width novo-frame 1800 nil t) ; Define a largura para 120 colunas
     (set-frame-height novo-frame 980 nil t) ; Define altura
     (select-frame-set-input-focus novo-frame)
     (ansi-term "/bin/bash")
     (split-window-right)
     (ansi-term "/bin/bash")
     (split-window-below)
     (other-window 1)
     (ansi-term "/bin/bash")))

(defun meu-frame-magit ()
    "Abre o Magit em um novo frame."
     (interactive)
     (let ((novo-frame (make-frame-command)))
     (select-frame-set-input-focus novo-frame) ; Seleciona o novo frame
     (set-frame-width novo-frame 1800 nil t) ; Define a largura para 120 colunas
     (set-frame-height novo-frame 980 nil t) ; Define altura
     (select-frame-set-input-focus novo-frame)
     (magit-status) ; Inicia o Magit
     (split-window-right)
     (other-window 1) ; Move para a segunda janela
     (switch-to-buffer (other-buffer (current-buffer))) ; Abre o último buffer
     ))


(setq-default indent-tabs-mode nil) ; Use spaces instead of tabs
(setq-default tab-width 4) ; Set the tab width to 4 spaces
                           ;
(defun hide-mode-line-in-term ()
  (when (equal major-mode 'term-mode)
    (setq-local mode-line-format " ")))

(add-hook 'after-change-major-mode-hook 'hide-mode-line-in-term)

(global-set-key (kbd "C-x g") 'meu-frame-magit)
(global-set-key (kbd "C-x t") 'meu-frame-vertical)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


(winner-mode)
(global-set-key (kbd "C-c <left>") 'winner-undo)

(add-hook 'after-init-hook 'global-company-mode)

;; Cargar el archivo gnus.el si existe
(let ((gnus-config-file (expand-file-name ".gnus.el" user-emacs-directory)))
   (when (file-exists-p gnus-config-file)
       (load gnus-config-file)))
