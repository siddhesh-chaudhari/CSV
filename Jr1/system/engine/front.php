<?php
final class Front {
	protected $registry;
	protected $pre_action = array();
	protected $error;
	
	public function __construct($registry) {
		$this->registry = $registry;
	}
	
	public function addPreAction($pre_action) {
		$this->pre_action[] = $pre_action;
	}
	
  	public function dispatch($action, $error) {
		$this->error = $error;

        /* Journal2 Theme modification */
        if (!in_array($action->getClass(), array('Controllerjournal2assets'))) {
        /* End of Journal2 Theme modification */
            foreach ($this->pre_action as $pre_action) {
                $result = $this->execute($pre_action);

                if ($result) {
                    $action = $result;

                    break;
                }
            }
        /* Journal2 Theme modification */
        }
        /* End of Journal2 Theme modification */

        /* Journal2 Theme modification */
        require_once(DIR_SYSTEM . 'journal2/startup.php');
        /* End of Journal2 Theme modification */

		while ($action) {
			$action = $this->execute($action);
		}
  	}
    
	private function execute($action) {
		if (file_exists($action->getFile())) {
			require_once($action->getFile());
			
			$class = $action->getClass();

			$controller = new $class($this->registry);
			
			if (is_callable(array($controller, $action->getMethod()))) {
				$action = call_user_func_array(array($controller, $action->getMethod()), $action->getArgs());
			} else {
				$action = $this->error;
			
				$this->error = '';
			}
		} else {
			$action = $this->error;
			
			$this->error = '';
		}
		
		return $action;
	}
}
?>