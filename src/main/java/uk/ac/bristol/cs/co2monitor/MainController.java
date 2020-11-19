package uk.ac.bristol.cs.co2monitor;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {
    @GetMapping("/hello")
    public String doHello(Model m, @RequestParam String name) {
        m.addAttribute("name", name);
        return "hello";
    }
}
