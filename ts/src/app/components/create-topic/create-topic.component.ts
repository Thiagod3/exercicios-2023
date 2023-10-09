import { Component, OnInit } from '@angular/core';

import { Status } from '../../enum/enum-status'

@Component({
  selector: 'app-create-topic',
  templateUrl: './create-topic.component.html',
  styleUrls: ['./create-topic.component.scss']
})
export class CreateTopicComponent implements OnInit {
  public Status = Status;
  public status: Status = this.Status.Inicio;

  constructor() { }

  ngOnInit(): void {
  }

  alterarStatus(novoStatus: Status) {
    this.status = novoStatus;
  }

}
