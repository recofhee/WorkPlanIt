package all.action;
import java.sql.Connection;
import java.sql.Timestamp;
//  투두 실제 내용
public class TodoDataBean {

    private Integer mem_num;

    private Integer todo_index;

    private Timestamp todo_writetime;

    private String todo_text;

    private Integer todo_complete;

    public Integer getMem_num() {
        return mem_num;
    }

    public void setMem_num(Integer mem_num) {
        this.mem_num = mem_num;
    }

    public Integer getTodo_index() {
        return todo_index;
    }

    public void setTodo_index(Integer todo_index) {
        this.todo_index = todo_index;
    }

    public Timestamp getTodo_writetime() {
        return todo_writetime;
    }

    public void setTodo_writetime(Timestamp todo_writetime) {
        this.todo_writetime = todo_writetime;
    }

    public String getTodo_text() {
        return todo_text;
    }

    public void setTodo_text(String todo_text) {
        this.todo_text = todo_text;
    }

    public Integer getTodo_complete() {
        return todo_complete;
    }

    public void setTodo_complete(Integer todo_complete) {
        this.todo_complete = todo_complete;
    }

   
}