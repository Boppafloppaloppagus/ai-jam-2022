using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class NPCController : MonoBehaviour
{

    public GameObject playaPlaya;

    public NavMeshAgent agent;

    // Update is called once per frame
    void Update()
    {

        agent.SetDestination(playaPlaya.transform.position);
          
    }
}
