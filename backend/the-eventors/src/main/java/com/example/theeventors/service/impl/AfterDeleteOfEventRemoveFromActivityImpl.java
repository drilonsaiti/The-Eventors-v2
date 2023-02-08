package com.example.theeventors.service.impl;

import com.example.theeventors.model.MyActivity;
import com.example.theeventors.repository.MyActivityRepository;
import com.example.theeventors.service.AfterDeleteOfEventRemoveFromActivity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class AfterDeleteOfEventRemoveFromActivityImpl implements AfterDeleteOfEventRemoveFromActivity {

    private final MyActivityRepository myActivityRepository;

    public AfterDeleteOfEventRemoveFromActivityImpl(MyActivityRepository myActivityRepository) {
        this.myActivityRepository = myActivityRepository;
    }

    @Override
    public void delete(Long id) {
        List<MyActivity> activities = this.myActivityRepository.findAll();
        List<MyActivity> activity = activities.stream().filter(u -> u.getMyGoingEvent().keySet().stream().anyMatch(b -> b == id) ||
                u.getMyInterestedEvent().keySet().stream().anyMatch(b -> b.equals(id))).toList();
        for (MyActivity ac :  activity){
            if (ac.getMyInterestedEvent().keySet().stream().anyMatch(a -> a.equals(id))){
                ac.getMyInterestedEvent().remove(id);
                this.myActivityRepository.save(ac);
            }else{
                ac.getMyGoingEvent().remove(id);
                this.myActivityRepository.save(ac);

            }
            if (ac.getMyComments().entrySet().stream().anyMatch(c -> c.getValue().equals(id))){
                Map<Long,Long> map =  ac.getMyComments().entrySet().stream().filter(c -> c.getValue().equals(id))
                        .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));;
                for (Map.Entry<Long, Long> s : map.entrySet()){
                    System.out.println(s.getValue());
                    ac.getMyComments().remove(s.getKey());
                    this.myActivityRepository.save(ac);
                }
            }
        }
    }
}
