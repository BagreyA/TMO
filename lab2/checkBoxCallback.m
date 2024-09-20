function checkBoxCallback(hObject,eventData,checkBoxId,a)
    value = get(hObject,'Value');
     if value ~= 0
        switch checkBoxId
            case 1
                set(a(1),'Visible','on');
            case 2
                set(a(2),'Visible','on');
            case 3
                set(a(3),'Visible','on');
        end
     else 
          set(a(checkBoxId),'Visible','off');

     end
   
end
