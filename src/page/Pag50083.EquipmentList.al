page 50083 "Equipment Driver List"
{
    PageType = List;
    SourceTable = "Fixed Asset";
    SourceTableView = where("Responsible Employee" = filter('*'), "Equipment Status"= const(Available));
    Caption = 'Equipments';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.") { }
                //field(Date; Rec.Date) { }
                field("Description"; Rec."Description") { }
                 field("Location"; Rec."FA Location Code") { }
                 field("Model"; Rec."Model") { }
                 field("Equipment Type"; Rec."Equipment Type") { }
                // field(Status; Rec.Status) { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // action(OpenIncident)
            // {
            //     Caption = 'Open Incident';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Incident Form";
            //     RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
            // }
        }
    }
    var
      FormHeader: Record "Form Header";
}