page 50082 "Client Complaint List"
{
    PageType = List;
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = const("Incident Notification Form"), "Complaint No."= filter(<>''));
    Caption = 'Client Complaints';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."Complaint No.") { }
                field(Date; Rec.Date) { }
                field("Driver No."; Rec."Driver No.") { }
                field("Driver Name"; Rec."Driver Name") { }
                field("Equipment No."; Rec."Equipment No.") { }
                field("Equipment Name"; Rec."Equipment Name") { }
                field(Status; Rec.Status) { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OpenIncident)
            {
                Caption = 'Open Complaint';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Incident Form";
                RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
            }
        }
    }
}