<?php
    class Usuarios {
        public $usuario1 = "Mauricio";

        // Método vulnerable que ejecuta un comando de shell
        public function ejecutarComando($comando) {
            // Concatenación insegura de comandos (Riesgo de inyección)
            $salida = shell_exec("ls -l " . $comando);  // Ejecución de comando con shell
            return $salida;
        }
    }

    // Simulación de un atacante que pasa un comando malicioso
    $usuario = new Usuarios();
    
    // Ejemplo vulnerable: el atacante podría manipular la entrada
    echo $usuario->ejecutarComando(" /etc/passwd ");  // Muestra el contenido de /etc/passwd
?>
