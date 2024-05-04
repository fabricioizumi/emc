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
   '(org-pomodoro helm-flymake flymake-flycheck marginalia selectrum-prescient selectrum dumb-jump flycheck-eglot flycheck-google-cpplint flycheck-kotlin kotlin-mode android-env android-mode ivy-todo projectile-ripgrep ivy-yasnippet ivy-file-preview ivy-fuz ivy-xref ivy-searcher ivy ag helm-fuzzy-find helm-searcher helm flycheck lsp-ui lsp-mode neotree projectile darcula-theme magit which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-face-attribute 'default nil :font "JetBrainsMono NFP" :height 140)

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

;; set key board shorcuts
(global-set-key (kbd "C-x g") 'magit-status)

;; set theme
(load-theme 'darcula t)

(setq inhibit-startup-screen t)

;; Ativar o Projectile
(projectile-mode +1)
(setq projectile-completion-system 'ivy)

;; Ativar o Neotree
(require 'neotree)
(global-set-key (kbd "C-x n") 'neotree-toggle)

(ivy-mode 1)
(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))

(setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
;; Ativar o lsp-mode
;;(require 'lsp-mode)
;;(add-hook 'prog-mode-hook #'lsp)

;; Ativar o lsp-ui
;;(require 'lsp-ui)
;;(add-hook 'lsp-mode-hook #'lsp-ui-mode)

;; Ativar o flycheck
;;(require 'flycheck)
;;(global-flycheck-mode)

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)

(setq initial-frame-alist
      '((width . 170)    ; Largura da janela em caracteres
        (height . 42)))  ; Altura da janela em linhas
