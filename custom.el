(defun my-first-function ()
       "Primeira funcao."
       (interactive)
       ;;; Code:
       (message "Hello World de novo e novo!!")
       ;;body function
)

(defun my-second-function ()
  "Segunda funcao. Executa comando no terminal."
  (interactive)
  (let ((resultado (shell-command-to-string "ls")))
        (message "Arquivos\n%s" resultado) )
)

(provide 'custom-module)
;;; custom.el ends here

