page 50075 "Incident Form List"
{
    PageType = List;
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = const("Incident Notification Form"), "Description"= filter(<>''));
    Caption = 'Incident Forms';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.") { }
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
                Caption = 'Open Incident';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Incident Form";
                RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
            }
        }
    }
}